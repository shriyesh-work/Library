class SessionsController < ApplicationController

  def new
    if find_user
        redirect_to new_home_path
    end
  end

  def create
    user = User.authenticate params.require(:user).permit(:email, :password)
    if user
      cookies.permanent.signed[:user_logged] = user.id;
      if user.is_admin
        redirect_to admin_users_path
      else
        redirect_to new_home_path
      end
    else
      flash[:error] = "Invalid Username/Password!"
      render :new
    end
  end

  def destroy
    cookies.delete(:user_logged)
    redirect_to new_session_path
  end

  private

  def user_logged
    unless find_user
      flash[:error] = "You need to login first!"
      redirect_to new_session
    end
  end

  def find_user
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
    else
      nil
    end
  end
end