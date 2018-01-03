require 'test_helper' 

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:some_book)
  end

  test 'redirect_login_if_not_authenticated' do 
    #cookies['user_logged'] = "NDM5NTgzOTkw--599ae82b17d75ea6024fecace8e28070b18bf2d7"
    get books_path
    assert_equal 302, @response.status
    get book_path(@book)
    assert_equal 302, @response.status
  end

  test 'index_action_succesful' do
    post session_path, params: { user: { email: 'rose@gmail.com', password: 'rose123'} }
    get books_path
    assert_equal 200, @response.status
  end

  test 'show_action_succesful' do 
    post session_path, params: { user: { email: 'rose@gmail.com', password: 'rose123'} }
    get book_path(@book.isbn)
    assert_equal 200, @response.status
  end

end