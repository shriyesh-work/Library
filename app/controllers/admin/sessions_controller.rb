class Admin::SessionsController < ApplicationController

  private

  def user_logged
    unless cookies.signed[:user_logged] and find_user and find_user.is_admin 
      flash[:error] = "You need to login first!"
      redirect_to login_path
    end
  end

  def find_user
    @user_logged = User.find(cookies.signed[:user_logged])
  end
end