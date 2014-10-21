require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    post :create, name: 'XnnYygn', password: 'secret'
    assert_redirected_to root_url
  end

  test "should login failed" do
    post :create, name: 'XnnYygn', password: 'incorrect'
    assert_redirected_to login_url
  end

  test "should delete destroy" do
    delete :destroy
    assert_redirected_to root_url
  end

end
