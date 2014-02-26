module Actions
  def index
    respond_with collection, &responder
  end

  def show
    respond_with resource, &responder
  end

  def create
    resource = set_or_retrieve "#{resource_class_name.downcase}",
      resource_class.build(permited_params)
    if resource.save
      @action_successful = true
      respond_with resource, notice: messages[:create],
        location: redirect_path(__method__.to_sym, resource), &responder
    else
      @action_successful = false
      respond_with resource, &responder
    end
  end

  def update
    if resource.update permited_params
      @action_successful = true
      respond_with resource, notice:    messages[:update],
        location:  redirect_path(__method__.to_sym), &responder
    else
      @action_successful = false
      render :edit
    end
  end

  def destroy
    if resource.destroy
      redirect_to action: :index
    else
      redirect_to resource, notice: messages[:error]
    end
  end

  private

  def redirect_path(action, resource = resource)
    resource_chain.objects << resource
  end

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
