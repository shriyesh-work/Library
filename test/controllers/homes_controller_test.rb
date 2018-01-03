require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest

  test 'redirect_login_if_not_authenticated' do
    get new_home_path
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
    get home_path
    assert_equal 302, @response.status
    assert_redirected_to new_session_path
  end

  test 'new_action_succesful' do
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} }
    get new_home_path
    assert_equal 200, @response.status
  end

  test 'show_action_succesful' do
    post session_path, params: { user: {email: 'jon@gmail.com', password: 'jon123'} }
    get home_path, params: { query: 'dummy' }, xhr: true
    assert_equal 200, @response.status
  end

end