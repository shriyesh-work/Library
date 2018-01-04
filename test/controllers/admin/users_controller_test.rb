require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:rose)
  end

  test 'redirect_if_not_authenticated_on_index' do 
    get admin_users_path
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_create' do 
    post admin_users_path
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_new' do 
    get new_admin_user_path
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_edit' do 
    get edit_admin_user_path(@user.username)
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_show' do 
    get admin_user_path(@user.username)
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_update' do 
    patch admin_user_path(@user.username), params: { user: { firstname: 'Rosa'}}
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_destroy' do 
    delete admin_user_path(@user.username)
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end

  test 'redirect_if_not_authenticated_on_search_users' do 
    post admin_users_search_path, params: { query: 'dummy'}
    assert_equal "Found", @response.message
    assert_redirected_to new_session_path
  end
  
  test 'admin_users_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get admin_users_path
    assert_equal "OK", @response.message
  end

  test 'new_admin_user_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get new_admin_user_path
    assert_equal "OK", @response.message
  end

  test 'create_new_user_and_redirect_to_show_path' do 
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    post admin_users_path, params: { user: {firstname: 'jon', lastname: 'smith', email: 'jon1@gmail.com', password: 'jon123'}}
    assert_equal "Found", @response.message
    new_user = User.find_by(email: 'jon1@gmail.com')
    assert_redirected_to admin_user_path(new_user.username)
  end

  test 'edit_admin_user_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get edit_admin_user_path(@user.username)
    assert_equal "OK", @response.message
  end

  test 'show_admin_user_path_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    get admin_user_path(@user.username)
    assert_equal "OK", @response.message
  end
  
  test 'update_user_and_redirect_to_show_path' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    patch admin_user_path(@user.username), params: { user: { firstname: 'Jonah' }}
    updated_user = User.find(@user.id)
    assert_equal "Found", @response.message
    assert_redirected_to admin_user_path(@user.username)
    assert_equal 'Jonah', updated_user.firstname
  end

  test 'destroy_user_and_redirect_admin_users_path' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} } 
    delete admin_user_path(@user.username)
    assert_nil User.find_by(id: @user.id)
    assert_equal "Found", @response.message
    assert_redirected_to admin_users_path
  end

  test 'search_users_response_ok' do
    post session_path, params: { user: {email: 'rose@gmail.com', password: 'rose123'} }
    post admin_users_search_path, params: { query: 'dummy'}, xhr: true
    assert_equal "OK", @response.message
    assert_equal "text/javascript", @response.content_type
  end


end