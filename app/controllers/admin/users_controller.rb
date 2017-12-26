class Admin::UsersController < Admin::AdminController

  def index 
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(user)
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
    user
  end

  def show
    user
  end

  def update
    if user.update(user_params) 
      redirect_to admin_user_path(user)
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    redirect_to admin_users_path
  end

  def search_users
    @users = User.where("firstname LIKE :query", query: "%#{params[:query]}%")
  end

  private 
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin)
    end

    def user
      @user = User.find_by(username: params[:username])
    end
end