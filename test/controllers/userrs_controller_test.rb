require 'test_helper'

class UserrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userr = userrs(:one)
  end

  test "should get index" do
    get userrs_url
    assert_response :success
  end

  test "should get new" do
    get new_userr_url
    assert_response :success
  end

  test "should create userr" do
    assert_difference('Userr.count') do
      post userrs_url, params: { userr: { challenge_request: @userr.challenge_request, challenge_result: @userr.challenge_result, device_id: @userr.device_id, level: @userr.level, nickname: @userr.nickname, score_0_online: @userr.score_0_online, score_1_online: @userr.score_1_online, score_2_online: @userr.score_2_online, score_single: @userr.score_single, try_challenge: @userr.try_challenge, win_challenge: @userr.win_challenge } }
    end

    assert_redirected_to userr_url(Userr.last)
  end

  test "should show userr" do
    get userr_url(@userr)
    assert_response :success
  end

  test "should get edit" do
    get edit_userr_url(@userr)
    assert_response :success
  end

  test "should update userr" do
    patch userr_url(@userr), params: { userr: { challenge_request: @userr.challenge_request, challenge_result: @userr.challenge_result, device_id: @userr.device_id, level: @userr.level, nickname: @userr.nickname, score_0_online: @userr.score_0_online, score_1_online: @userr.score_1_online, score_2_online: @userr.score_2_online, score_single: @userr.score_single, try_challenge: @userr.try_challenge, win_challenge: @userr.win_challenge } }
    assert_redirected_to userr_url(@userr)
  end

  test "should destroy userr" do
    assert_difference('Userr.count', -1) do
      delete userr_url(@userr)
    end

    assert_redirected_to userrs_url
  end
end
