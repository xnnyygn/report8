require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile, id: users(:xy).id
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

end
