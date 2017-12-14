require 'test_helper.rb'

class DashboardControllerTest < ActionDispatch::IntegrationTest

  test "should go to login" do 
    get '/dashboard'
    assert_equal 'Login to access dashboard', flash[:alert]
    assert_response :redirect
  end

  test "should go to login for new user" do 
    get '/dashboard/new_user'
    assert_equal 'Login to access dashboard', flash[:alert]
    assert_response :redirect
  end

  test "should set count" do
    get '/dashboard/list_users', params: {count: 3} 
    assert_select "a[href=?]", "/dashboard/list_users?count=0"
    assert_select "a[href=?]", "/dashboard/list_users?count=2"
  end

end