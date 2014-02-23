class Users::Contacts::InstallationsController < ApplicationController
  respond_to :js

  has_scope :about_to_expire, type: :boolean
  has_scope :next_service_near, type: :boolean

  def prepare_collection(c)
    decorate_collection(
      apply_scopes(c).page(params[:installations_page]).per(10)
    )
  end
end
