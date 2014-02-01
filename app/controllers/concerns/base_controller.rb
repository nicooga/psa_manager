class BaseController < ApplicationController
  ### DSL
  class_attribute :parent_class_name
  class_attribute :permited_params_keys

  def self.belongs_to(resource_name = nil)
    self.parent_class_name ||= resource_name
  end

  def self.permit_params(*args)
    self.permited_params_keys ||= args
  end

  ### PERSISTANCE
  before_filter :find_resource, only: [:show, :edit, :update, :destroy]
  before_filter :find_collection, only: :index
  before_filter :build_resource, only: :new

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

  def messages
    { create: "Succesfully created #{resource_class_name.downcase}",
      update: "Succesfully updated #{resource_class_name.downcase}",
      error:  "Something went wrong." }
  end

  ### RESOURCE
  def permited_params
    params.require(resource_class_name.downcase.to_sym).permit permited_params_keys
  end

  def belongs_to?
    !!self.class.parent_class_name
  end

  def parent_class
    @parent_class ||= send self.class.parent_class_name
  end

  def find_collection
    instance_variable_set "@#{resource_class_name.downcase.pluralize}", resource_class.all.map(&:decorate)
  end

  def build_resource
    instance_variable_set "@#{resource_class_name.downcase}", resource_class.new
  end

  def resource
    instance_variable_get "@#{resource_class_name.downcase}"
  end

  def find_resource
    instance_variable_set "@#{resource_class_name.downcase}", resource_class.find(params[:id]).decorate
  end

  def resource_class
    if belongs_to?
      parent_class.send params[:controller]
    else
      resource_class_name.constantize
    end
  end

  def resource_class_name
    params[:controller].singularize.capitalize
  end
end
