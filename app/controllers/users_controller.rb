class UsersController < SessionsController
  
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
    if cookies.signed[:user_logged] and find_user
      redirect_to home_path
    end
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

  def home
    @new_books = Book.order(created_at: :desc).limit(5)
  end

  def search
    if params[:query].empty?
      @books = Book.search
    else
      @books = Book.search "*"+params[:query]+"*"
    end
  end

  def books
    @records = Record.includes(:book).where(user_id: @user_logged.id, returned: false)
  end

  def book
    @book = Book.find_by(isbn: params[:isbn])
    @record = Record.find_by(book_id: @book.id, returned: false)
  end

  def borrow
    unless Record.find_by(book_id: params[:id], user_id: @user_logged.id, returned: false)
      @record = Record.new(book_id: params[:id], user_id: @user_logged.id)
      @record.save
    end
    redirect_to books_path
  end

  def return
    @record = Record.find_by(book_id: params[:id],user_id: @user_logged.id, returned: false)
    #unless @record.created_at.to_date.eql? DateTime.now.to_date
      @record.update(returned: true)
    #end
    redirect_to books_path
  end

  private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :is_admin) if params[:user]
  end
end