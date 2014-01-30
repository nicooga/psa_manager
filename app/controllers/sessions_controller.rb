class SessionsController < ApplicationController
  def create
    user = User.fetch(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path, notice: "Welcome back #{user.email}"
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logged out'
  end

  private

  def auth_hash() env['omniauth.auth'] end
end
