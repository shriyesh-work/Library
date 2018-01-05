require 'test_helper'

class LibraryRecordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @record = library_records(:record_borrowed_jon)
    @book = books(:some_book)
  end

  test 'redirect_login_if_not_authenticated' do 
    get library_record_path(@book)
    assert_equal 302, @response.status
    delete library_record_path(@book)
    assert_equal 302, @response.status
  end

  test 'redirect_books_path_if_record_exist' do
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} } 
    get library_record_path(@book)
    assert_equal 302, @response.status
    assert_redirected_to books_path
  end

  test 'destroy_record_redirect_books_path' do
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} } 
    delete library_record_path(@book)
    assert_equal true, LibraryRecord.find(@record.id).returned 
    assert_equal 302, @response.status
    assert_redirected_to books_path
  end


end