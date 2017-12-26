class SessionsController < ApplicationController

  def login
    if request.get?
      Rails.logger.info "Hello!!! Blah blah blah"
    elsif request.post?
      user = User.authenticate params.require(:user).permit(:email, :password)
      if user
        cookies.permanent.signed[:user_logged] = user.id;
        if user.is_admin
          redirect_to admin_users_url
        else
          redirect_to profile_url
        end
      else
        flash[:error] = "Invalid Username/Password!"
        render :login
      end
    end
  end

  def logout
    cookies.delete(:user_logged)
    redirect_to login_url
  end

end