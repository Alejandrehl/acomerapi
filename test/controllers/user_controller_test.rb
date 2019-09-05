require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get getUser" do
    get user_getUser_url
    assert_response :success
  end

end
