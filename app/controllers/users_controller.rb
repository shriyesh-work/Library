class UsersController < ApplicationController

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    if cookies.signed[:user_id]
      @user_in = User.find(cookies.signed[:user_id])
    end
    @user_new = User.new(user_params)
    if @user_new.save 
      if @user_in
          flash[:alert] = "Added user succesfully!"
          redirect_to :dashboard_new_user
      else
          redirect_to @user_new
      end
    else
      render "dashboard/new_user", params: user_params
    end
  end

  def update
    @user = User.find(params[:id]);
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin)
    end
end