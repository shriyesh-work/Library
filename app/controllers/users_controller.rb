class UsersController < ApplicationController
  
  before_action :user_logged, except: [:new, :create]
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:error] = "Login with your new account!"
      redirect_to login_path
    else
      render :new
    end
  end

  def new 
    @user = User.new
  end

  def edit
  end

  def show
  end

  def update
    if @user_logged.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
  end

  private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin) if params[:user]
  end

  def user_logged
    if cookies.signed[:user_logged] 
      @user_logged = User.find(cookies.signed[:user_logged]) 
    else
      flash[:error] = "You need to login first!"
      redirect_to login_path
    end
  end

end