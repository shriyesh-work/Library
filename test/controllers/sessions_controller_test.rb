require 'test_helper.rb'
class SessionsControllerTest < ActionDispatch::IntegrationTest

  # Test for login page
  test "should get login" do 
    cookies[:user_id] = 1
    get '/login'
    assert_response :success
  end

  # Test for login successful
  test "should take to dashboard" do 
    post '/login', params: { user: { email: 'rahul@gmail.com', password: 'rahul123'} }
    assert_redirected_to '/dashboard' 
  end

  # Test for flash message
  test "should flash invalid username or password" do
    post '/login', params: { user: { email: 'rahul@gmail.com', password: 'rahul12'} }
    assert_equal 'Invalid/Username Password', flash[:alert]
  end
end
