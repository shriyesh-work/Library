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
    assert @controller.instance_variable_get(:@records).first.eql? @record
  end
  
end