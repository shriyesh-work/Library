require 'test_helper'

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:some_book)
  end

  test 'redirect_to_login_if_not_authenticated_on_index' do
    get admin_books_path
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'redirect_to_login_if_not_authenticated_on_create' do
    post admin_books_path
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'redirect_to_login_if_not_authenticated_on_new' do
    get new_admin_book_path
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'redirect_to_login_if_not_authenticated_on_edit' do
    get edit_admin_book_path(@book.id)
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'redirect_to_login_if_not_authenticated_on_update' do
    put admin_book_path(@book.id)
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
    patch admin_book_path(@book.id)
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'redirect_to_login_if_not_authenticated_on_show' do
    get admin_book_path(@book.id)
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'redirect_to_login_if_not_authenticated_on_destroy' do
    delete admin_book_path(@book.id)
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'create_new_book_redirect_to_show_path' do 
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    post admin_books_path, params: {book: { name: 'New Book', author: 'New Book Author', isbn: 123432323, category_id: category(:comedy).id }}
    assert_equal 302, @response.status
    assert_redirected_to admin_book_path(Book.find_by(isbn: 123432323).id)
  end
  
=begin
  test 'update_book_redirect_to_show' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    patch admin_book_path, params: {book: { name: 'Rename New Book' }}
  end
=end

end