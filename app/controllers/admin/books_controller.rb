class Admin::BooksController < Admin::SessionsController

  before_action :user_logged

  def index
    #@books = Book.all
    @books = Book.search
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_book_path(@book)
    else
      render :new
    end
  end

  def new
    @book = Book.new
  end

  def edit
    book
  end

  def show
    book
  end

  def update
    if book.update(book_params)
      redirect_to admin_book_path(book)
    else
      render :edit
    end
  end

  def destroy
    book.destroy
    redirect_to admin_books_path
  end

  def search_books
    #@books = Book.where("name LIKE :query", query: "%#{params[:query]}%")
    if params[:query].empty?
      @books = Book.search
    else
      @books = Book.search "*"+params[:query]+"*"
    end
  end

  private
    def book_params
      params.require(:book).permit(:name, :author, :isbn, :category_id)
    end

    def book
      @book = Book.find(params[:id])
    end
end