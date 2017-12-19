class UsersController < ApplicationController
  
  def index
    if cookies.signed[:user_logged]
      redirect_to admin_users_path
    end
  end

  def create
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
    end
    @user = User.new(user_params)
    if @user.save
      flash[:alert] = "Login with your new account!"
      render :index
    else
      render :new, user_params
    end
  end

  def new
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
    end
    @user = User.new(firstname: params[:firstname],lastname: params[:lastname],email: params[:email])
  end

  def edit
    @user = User.find(params[:id])
    @user_logged = User.find(cookies.signed[:user_logged])
  end

  def show
    @user = User.find(params[:id])
    @user_logged = User.find(cookies.signed[:user_logged])
  end

  def update
    @user_logged = User.find(cookies.signed[:user_logged])
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:alert] = "Profile is Updated!"
      render :show
    else
      render :edit
    end
  end

  def destroy
  end

  def login
    user = User.authenticate params.require(:user).permit(:email, :password)
    if user
      cookies.permanent.signed[:user_logged] = user.id;
      redirect_to admin_users_path
    else
      flash[:alert] = "Invalid Username/Password!"
      render :index
    end
  end

  def logout
    if cookies.signed[:user_logged]
      cookies.delete :user_logged
      flash[:alert] = "Logged Out Successfully"
    end
    redirect_to :users
  end

  private 
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin)
    end

end