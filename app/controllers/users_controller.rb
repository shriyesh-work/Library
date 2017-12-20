class UsersController < ApplicationController
  
  def index
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
      if @user_logged.is_admin
        redirect_to admin_users_path
      else
        redirect_to user_home_path
      end
    end
  end

  def create
    @user = User.new(user_params)
    @user_logged = User.find(cookies.signed[:user_logged]) if cookies.signed[:user_logged]
    if @user.save
      if @user_logged
        flash[:alert] = "New User Added!"
        redirect_to @user
      else
        flash[:alert] = "Login with your new account!"
        render :index
      end
    else
      render :new, user_params
    end
  end

  def new
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
      redirect_to user_home_path if not @user_logged.is_admin
    end
    @user = User.new(firstname: params[:firstname],lastname: params[:lastname],email: params[:email])
  end

  def edit
    @user_logged = User.find(cookies.signed[:user_logged])
    if (not @user_logged.is_admin) and @user_logged.id != params[:id]
      @user = User.find(@user_logged.id)
    else
      @user = User.find(params[:id])
    end
  end

  def show
    @user_logged = User.find(cookies.signed[:user_logged])
    if (not @user_logged.is_admin) and @user_logged.id != params[:id]
      @user = User.find(@user_logged.id)
    else
      @user = User.find(params[:id])
    end
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
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def login
    if cookies.signed[:user_logged]
      redirect_to admin_users_path
    else
      user = User.authenticate params.require(:user).permit(:email, :password)
      if user
        cookies.permanent.signed[:user_logged] = user.id;
        if not user.is_admin
          redirect_to user_home_path
        else
          redirect_to admin_users_path
        end
      else
        flash[:alert] = "Invalid Username/Password!"
        render :index
      end
    end
  end

  def logout
    if cookies.signed[:user_logged]
      cookies.delete :user_logged
      flash[:alert] = "Logged Out Successfully"
    end
    redirect_to :users
  end

  def user_home
    @user_logged = User.find(cookies.signed[:user_logged]) if cookies.signed[:user_logged]
    @books = Book.all.limit(10).reverse
  end

  private 
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin)
    end

end