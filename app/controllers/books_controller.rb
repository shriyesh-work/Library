class BooksController < ApplicationController

  def index
    redirect_to new_book_path
  end

  def create
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
    end
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new', book_params
    end
  end

  def new
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
    end
    @book = Book.new #(name: params[:name], author: params[:author], isbn: params[:isbn], category: params[:category])
    @categories = Category.all
  end

  def edit
    if cookies.signed[:user_logged]
      @user_logged = User.find(cookies.signed[:user_logged])
    end
    @book = Book.find(params[:id])
  end

  def show
    @user_logged = User.find(cookies.signed[:user_logged]) 
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end

  private
    def book_params
      params.require(:book).permit(:name, :author, :isbn, :category_id)
    end
end