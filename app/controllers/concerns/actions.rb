module Actions
  def index
    respond_with collection, &responder
  end

  def show
    respond_with resource, &responder
  end

  def create
    resource = instance_variable_set "@#{resource_class_name.downcase}",
      resource_class.new(permited_params)
    if resource.save
      @action_successful = true
      respond_with resource, notice: messages[:create], &responder
    else
      @action_successful = false
      respond_with resource, &responder
    end
  end

  def update
    if resource.update permited_params
      respond_with resource, notice: messages[:update]
    else
      render :edit
    end
  end

  def destroy
    if resource.destroy
      respond_with resource, notice: messages[:destroy]
    else
      redirect_to resource, notice: messages[:error]
    end
  end

  private

  def permited_params
    params.fetch(resource_class_name.downcase.to_sym, {}).permit permited_params_keys
  end

  def action_successful?() @action_successful end

  def messages
    Hash.new('').merge(
      create: "Succesfully created #{resource_class_name.downcase}",
      update: "Succesfully updated #{resource_class_name.downcase}",
      error:  "Something went wrong."
    )
  end

  def responder
    responder_method_name = :"#{params[:action]}_responder"
    respond_to?(responder_method_name) ? method(responder_method_name) : ->(format) do
      format.js { render "#{params[:action]}.js.erb", layout: false }
    end
  end
end
