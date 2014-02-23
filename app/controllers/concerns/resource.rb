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

  def resource_class_name
    resource_chain.last.singularize.capitalize
  end

  def resource_class
    if resource_chain.one?
      resource_chain.first.camelcase.constantize
    else
      resolve_resource_chain
    end
  end

  def resource_chain
    controller_path.split('/').map(&:singularize)
  end

  def resolve_resource_chain
    root_class = resource_chain.first.camelcase.constantize
    root = root_class.find(params["#{root_class.model_name.element}_id"])

    resource_chain[1..-2].inject(root) do |table, assoc|
      table.send(assoc.pluralize).find(params["#{assoc}_id"])
    end.send(resource_chain.last.pluralize)
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
end
