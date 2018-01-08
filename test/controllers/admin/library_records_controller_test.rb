require 'test_helper'

class Admin::LibraryRecordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @record = library_records(:record_borrowed_rose)
  end

  test "index_should_redirect_on_not_authenticated" do 
    get admin_library_records_path
    assert_redirected_to new_session_path
  end

  test "index_should_return_records_instance_on_authenticated" do 
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get admin_library_records_path
    assert controller.instance_variable_get(:@records).first.eql? @record
    assert_equal "text/html; charset=utf-8", response['content-type']
  end

  test "index_should_return_records_of_borrowed_books" do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} }
    get admin_library_records_path, params: { filter: "borrowed" }, xhr: true
    assert_equal 2, controller.instance_variable_get(:@records).count 
    assert_equal "text/javascript; charset=utf-8", response['content-type']
  end

  test "index_should_return_records_of_returned_books" do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} }
    get admin_library_records_path, params: { filter: "returned" }, xhr: true
    assert_equal 2, @controller.instance_variable_get(:@records).count 
    assert_equal "text/javascript; charset=utf-8", response['content-type']
  end

  
end