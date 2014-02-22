class Users::Contacts::InstallationsController < ApplicationController
  respond_to :js

  def collection
    @installations = super.page(params[:installation_page]).per(10)
  end
end
