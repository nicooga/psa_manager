module Resource
  private

  def resource
    set_or_retrieve(resource_class_name.underscore) do
      prepare_resource resource_class.find(params[:id])
    end
  end

  def collection
    set_or_retrieve(resource_class_name.underscore.pluralize) do
      prepare_collection(retrieve_collection)
    end
  end

  def retrieve_collection
    if resource_class.kind_of? ActiveRecord::Associations::CollectionProxy
      resource_class
    else
      resource_class.all
    end
  end

  def resource_chain
    @resource_chain ||= Chain.new(self, *controller_path.split('/').map(&:singularize))
  end

  def resource_class_name
    resource_chain.klass_name
  end

  def resource_class
    resource_chain.klass
  end

  def build_resource
    instance_variable_set "@#{resource_class_name.downcase}", resource_class.new
  end

  def set_or_retrieve(var_name, value = nil)
    name = "@#{var_name}"
    if instance_variable_defined?(name)
      instance_variable_get(name)
    else
      if block_given?
        instance_variable_set name, yield
      else
        instance_variable_set name, value
      end
    end
  end

  class Chain
    attr_reader :controller, :elements, :klass,
      :root, :end, :objects

    def initialize(controller, *elements)
      @controller = controller
      @elements = elements
      resolve
      self
    end

    def klass
      @klass ||= if @elements.one?
        elements.first.camelcase.constantize
      else
        @end
      end
    end

    def klass_name
      elements.last.singularize.capitalize
    end

    private

    def resolve
      root_class = elements.first.camelcase.constantize
      @root = root_class.find(params["#{root_class.model_name.element}_id"])

      @end = elements[1..-2].inject(root) do |table, assoc|
        table.send(assoc.pluralize).find(params["#{assoc}_id"])
      end.send(elements.last.pluralize)


      @objects = elements[0..-2].map do |identifier|
        identifier.camelcase.constantize.find(params["#{identifier}_id"])
      end
    end

    def params
      controller.params
    end
  end
end
