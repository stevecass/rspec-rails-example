class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      login @user
      redirect_to root_path
    else
      flash[:notice] = "Bad email/password combination"
      redirect_to new_admin_session_path
    end
  end
end
