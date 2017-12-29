class SessionsController < ApplicationController

  def new
    #UI for entering credentials
  end

  def create
    #process login
  end

  def login
    if request.get?
      if cookies.signed[:user_logged] and find_user
        redirect_to home_path
      end
    elsif request.post?
      user = User.authenticate params.require(:user).permit(:email, :password)
      if user
        cookies.permanent.signed[:user_logged] = user.id;
        if user.is_admin
          redirect_to admin_users_path
        else
          redirect_to home_path
        end
      else
        flash[:error] = "Invalid Username/Password!"
        render :login
      end
    end
  end

  def logout
    cookies.delete(:user_logged)
    redirect_to login_path
  end

  private

  def user_logged
    unless cookies.signed[:user_logged] and find_user
      flash[:error] = "You need to login first!"
      redirect_to login_path
    end
  end

  def find_user
    @user_logged = User.find(cookies.signed[:user_logged])
  end
end