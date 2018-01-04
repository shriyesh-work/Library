require 'test_helper'

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:some_book) 
    @category = category(:comedy)
  end

  test 'redirect_if_not_authenticated_on_index' do
    get admin_books_path
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_create' do
    post admin_books_path
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_new' do
    get new_admin_book_path
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_edit' do
    get edit_admin_book_path(@book.id)
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_update' do
    put admin_book_path(@book.id), params: { book: {name: 'New Name', author: 'New Author', isbn: 213498763728, category_id: @category.id}}
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
    patch admin_book_path(@book.id), params: { book: {name: 'New Name'}}
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_show' do
    get admin_book_path(@book.id)
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_destroy' do
    delete admin_book_path(@book.id)
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_search_books' do 
    post admin_books_search_path, params: { query: 'dummy'}
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'admin_books_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get admin_books_path
    assert_equal "OK", @response.message
  end

  test 'new_admin_book_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get new_admin_book_path
    assert_equal "OK", @response.message
  end

  test 'create_new_book_and_redirect_to_show_path' do 
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    post admin_books_path, params: {book: { name: 'New Book', author: 'New Book Author', isbn: 123432323, category_id: @category.id }}
    assert_equal "Found", @response.message
    new_book = Book.find_by(isbn: 123432323)
    assert_redirected_to admin_book_path(new_book.id)
  end

  test 'edit_admin_book_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get edit_admin_book_path(@book)
    assert_equal "OK", @response.message
  end

  test 'show_admin_book_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get admin_book_path(@book)
    assert_equal "OK", @response.message
  end
  
  test 'update_book_and_redirect_to_show_path' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    patch admin_book_path(@book), params: {book: { name: 'Rename New Book' }}
    updated_book = Book.find_by(isbn: @book.isbn)
    assert_equal "Found", @response.message
    assert_redirected_to admin_book_path(@book.id)
    assert_equal 'Rename New Book', updated_book.name
  end

  test 'destroy_book_and_redirect_admin_books_path' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    delete admin_book_path(@book)
    assert_nil Book.find_by(id: @book.id)
    assert_equal "Found", @response.message
    assert_redirected_to admin_books_path
  end

  test 'search_books_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} }
    post admin_books_search_path, params: { query: 'dummy'}, xhr: true
    assert_equal "OK", @response.message
    assert_equal "text/javascript", @response.content_type
  end

end