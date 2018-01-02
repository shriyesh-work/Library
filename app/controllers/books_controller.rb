class BooksController < SessionsController

  before_action :user_logged

  def index
    @records = LibraryRecord.includes(:book).where(user_id: @user_logged.id, returned: false)
  end

  def show
    @book = Book.find_by(isbn: params[:isbn])
    @record = LibraryRecord.find_by(book_id: @book.id, returned: false)
  end

  

end