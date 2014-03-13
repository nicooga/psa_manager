class PagesController < ApplicationController
  skip_before_action :require_login
  layout 'page'

  def page
    render params[:page_name]
  end
end
