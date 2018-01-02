class HomesController < SessionsController

  before_action :user_logged

  def new
    @new_books = Book.order(created_at: :desc).limit(5)
  end

  def show
    if params[:query].empty?
      @books = Book.search
    else
      @books = Book.search "*"+params[:query]+"*"
    end
  end

end