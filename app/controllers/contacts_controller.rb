class ContactsController < ApplicationController
  before_filter :find_resource, only: [:show, :edit, :update, :destroy]
  before_filter :find_collection, only: :index
  before_filter :build_resource, only: :new
  before_filter :build_associated_entities, only: [:new, :edit]

  def create
    resource = instance_variable_set "@#{resource_class_name.downcase}",
      resource_class.new(permited_params)
    if resource.save
      redirect_to resource, notice: messages[:create]
    else
      render :new
    end
  end

  def update
    if resource.update permited_params
      redirect_to resource, notice: messages[:update]
    else
      render :edit
    end
  end

  def destroy
    if resource.destroy
      render :index, notice: messages[:destroy]
    else
      redirect_to resource, notice: messages[:error]
    end
  end

  private

  def permited_params
    params.require(resource_class_name.downcase.to_sym).permit :first_name, :last_name, :email, :birthday, :notes,
      addresses_attributes: [:id, :city, :state, :street, :number, :apartment, :zip_code, :notes, :_destroy]
  end

  def find_collection
    instance_variable_set "@#{resource_class_name.downcase.pluralize}", resource_class.all.map(&:decorate)
  end

  def build_resource
    instance_variable_set "@#{resource_class_name.downcase}", resource_class.new
  end

  def build_associated_entities
    associated_entities.each do |e|
      instance_variable_set "@#{e}", resource.send(e).new if resource.send(e).blank?
    end
  end

  def resource
    instance_variable_get "@#{resource_class_name.downcase}"
  end

  def find_resource
    instance_variable_set "@#{resource_class_name.downcase}", resource_class.find(params[:id]).decorate
  end

  def resource_class
    resource_class_name.constantize
  end

  def resource_class_name
    self.class.name.match(/(::)?(?<name>\w+)Controller$/)[:name].singularize
  end

  def messages
    { create: "Succesfully created #{resource_class_name.downcase}",
      update: "Succesfully updated #{resource_class_name.downcase}",
      error:  "Something went wrong." }
  end

  def associated_entities
    [:addresses]
  end
end
