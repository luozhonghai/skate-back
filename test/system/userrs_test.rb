require "application_system_test_case"

class UserrsTest < ApplicationSystemTestCase
  setup do
    @userr = userrs(:one)
  end

  test "visiting the index" do
    visit userrs_url
    assert_selector "h1", text: "Userrs"
  end

  test "creating a Userr" do
    visit userrs_url
    click_on "New Userr"

    fill_in "Challenge request", with: @userr.challenge_request
    fill_in "Challenge result", with: @userr.challenge_result
    fill_in "Device", with: @userr.device_id
    fill_in "Level", with: @userr.level
    fill_in "Nickname", with: @userr.nickname
    fill_in "Score 0 online", with: @userr.score_0_online
    fill_in "Score 1 online", with: @userr.score_1_online
    fill_in "Score 2 online", with: @userr.score_2_online
    fill_in "Score single", with: @userr.score_single
    fill_in "Try challenge", with: @userr.try_challenge
    fill_in "Win challenge", with: @userr.win_challenge
    click_on "Create Userr"

    assert_text "Userr was successfully created"
    click_on "Back"
  end

  test "updating a Userr" do
    visit userrs_url
    click_on "Edit", match: :first

    fill_in "Challenge request", with: @userr.challenge_request
    fill_in "Challenge result", with: @userr.challenge_result
    fill_in "Device", with: @userr.device_id
    fill_in "Level", with: @userr.level
    fill_in "Nickname", with: @userr.nickname
    fill_in "Score 0 online", with: @userr.score_0_online
    fill_in "Score 1 online", with: @userr.score_1_online
    fill_in "Score 2 online", with: @userr.score_2_online
    fill_in "Score single", with: @userr.score_single
    fill_in "Try challenge", with: @userr.try_challenge
    fill_in "Win challenge", with: @userr.win_challenge
    click_on "Update Userr"

    assert_text "Userr was successfully updated"
    click_on "Back"
  end

  test "destroying a Userr" do
    visit userrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Userr was successfully destroyed"
  end
end
