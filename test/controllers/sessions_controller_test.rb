require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test 'fail_login_on_invalid_credentials' do
    post session_path, params: { user: {email: 'blahblah', password: 'whatever'} } 
    assert_equal "Invalid Username/Password!", flash[:error]
  end

  test 'login_succesfully_with_valid_credentials' do 
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} } 
    assert @response.cookies.has_key? 'user_logged'
    refute_nil @response.cookies['user_logged']
    assert_redirected_to new_home_path
  end

  test 'redirect_to_home_page_if_already_logged' do
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} } 
    get new_session_path
    assert @request.cookies.has_key? 'user_logged'
    refute_nil @request.cookies['user_logged']
    assert_redirected_to new_home_path
  end 

  test 'login_succesfully_redirect_to_admin_panel' do 
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    assert @response.cookies.has_key? 'user_logged'
    refute_nil @response.cookies['user_logged']
    assert_redirected_to admin_users_path
  end

  test 'logout_and_redirect_to_login' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} }
    assert @response.cookies.has_key? 'user_logged'
    refute_nil @response.cookies['user_logged']
    delete session_path
    assert_nil @response.cookies['user_logged']
    assert_redirected_to new_session_path
  end
end
