class ApplicationController < BaseController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :require_login

  def root
    if current_user
      redirect_to dashboard_path
    else
      redirect_to page_path(:home)
    end
  end

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to page_path(:home), error: 'You must be logged in to see this page'
    end
  end
end
