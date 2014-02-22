class BaseController < ActionController::Base
  extend DSL
  include Actions
  include Resource
  include Decoration

  respond_to :html
  helper_method :resource
  before_filter :build_resource, only: :new

  class_attribute :permited_params_keys
  class_attribute :decorator
end
