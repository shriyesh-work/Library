class UsersController < SessionsController
  
  before_action :user_logged, except: [:new, :create]
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:error] = "Login with your new account!"
      redirect_to new_session_path
    else
      render :new
    end
  end

  def new 
    if find_user
      redirect_to new_home_path
    end
    @user = User.new
    
  end

  def edit
  end

  def show
  end

  def update
    if @user_logged.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin) if params[:user]
  end
end