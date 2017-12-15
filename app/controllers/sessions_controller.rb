class SessionsController < ApplicationController

  def index
    if cookies.signed[:user_id]
      redirect_to :dashboard
    end
  end

  def login
    user = User.authenticate params.require(:user).permit(:email, :password)
    if user
        cookies.permanent.signed[:user_id] = user.id
        redirect_to :dashboard
    else
        flash[:alert] = "Invalid/Username Password"
        render :index
    end
  end

  def logout
    if cookies.signed[:user_id]
      cookies.delete :user_id
      flash[:alert] = "Logged Out Succesfully"
    end
    redirect_to :login
  end

end