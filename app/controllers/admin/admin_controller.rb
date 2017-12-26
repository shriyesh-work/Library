class Admin::AdminController < ApplicationController
  
  before_action :user_logged

  private 
    def user_logged
      if cookies.signed[:user_logged] 
        unless find_user.is_admin
          redirect_to user_url
        end
      else
        flash[:error] = "You need to login first!"
        redirect_to login_url
      end
    end

    def find_user
      @user_logged = User.find(cookies.signed[:user_logged])
    end
end