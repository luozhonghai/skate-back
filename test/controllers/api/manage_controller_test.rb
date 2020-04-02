require 'test_helper'

class Api::ManageControllerTest < ActionDispatch::IntegrationTest
  test "should get auth" do
    get api_manage_auth_url
    assert_response :success
  end

  test "should get shot" do
    get api_manage_shot_url
    assert_response :success
  end

end
