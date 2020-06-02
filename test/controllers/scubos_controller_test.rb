require 'test_helper'

class ScubosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scubos_index_url
    assert_response :success
  end

  test "should get new" do
    get scubos_new_url
    assert_response :success
  end

  test "should get edit" do
    get scubos_edit_url
    assert_response :success
  end

end
