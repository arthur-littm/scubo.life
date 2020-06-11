require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_account" do
    get users_my_account_url
    assert_response :success
  end

end
