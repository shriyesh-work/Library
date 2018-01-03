require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:jon)
  end

  test 'if_not_authenticated_redirect_login' do
    get user_path
    assert_redirected_to new_session_path 
    get edit_user_path(@user)
    assert_redirected_to new_session_path
    patch user_path, params: { user: { firstname: 'dummy'} }
    assert_redirected_to new_session_path
    put user_path, params: { user: {firstname: 'jon', lastname: 'smith', email: 'jon1@gmail.com', password: 'jon123'}}
    assert_redirected_to new_session_path
  end

  test 'new_user_form__redirect_home_if_logged' do
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} }
    get new_user_path
    assert_equal  302, @response.status
    assert_redirected_to new_home_path
  end

  test 'create_new_user_and_redirect_login' do 
    post user_path, params: { user: {firstname: 'jon', lastname: 'smith', email: 'jon1@gmail.com', password: 'jon123'}}
    assert_equal  302, @response.status
    assert_redirected_to new_session_path
  end

  test 'update_user_and_redirect_to_user_path' do 
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} }
    patch user_path, params: { user: { firstname: 'dummy'} }
    assert_equal  302, @response.status
    assert_redirected_to user_path
  end



end