class ApplicationController < ActionController::Base
  def current_user
    @user ||= User.find session[:user_id] if session[:user_id]
    p @user
  end

  def authorize_user!
    redirect_to new_admin_session_path unless current_user.present?
  end

  def login user
    session[:user_id] = user.id
  end
end
