require 'test_helper'

class Api::SingleMapControllerTest < ActionDispatch::IntegrationTest
  test "should get is_user_unique" do
    get api_single_map_is_user_unique_url
    assert_response :success
  end

  test "should get get_score_rank" do
    get api_single_map_get_score_rank_url
    assert_response :success
  end

  test "should get update_user" do
    get api_single_map_update_user_url
    assert_response :success
  end

  test "should get get_user" do
    get api_single_map_get_user_url
    assert_response :success
  end

  test "should get toplist" do
    get api_single_map_toplist_url
    assert_response :success
  end

end
