require "application_system_test_case"

class BranchesTest < ApplicationSystemTestCase
  setup do
    @branch = branches(:one)
  end

  test "visiting the index" do
    visit branches_url
    assert_selector "h1", text: "Branches"
  end

  test "creating a Branch" do
    visit branches_url
    click_on "New Branch"

    fill_in "Email manager", with: @branch.email_manager
    fill_in "Hour cl", with: @branch.hour_cl
    fill_in "Hour op", with: @branch.hour_op
    fill_in "Information", with: @branch.information
    fill_in "Instagram api token", with: @branch.instagram_api_token
    fill_in "Instagram", with: @branch.instagram_id
    fill_in "Name", with: @branch.name
    fill_in "Restaurant", with: @branch.restaurant_id
    fill_in "Street", with: @branch.street
    fill_in "Telephone", with: @branch.telephone
    fill_in "Telephone manager", with: @branch.telephone_manager
    fill_in "User", with: @branch.user_id
    click_on "Create Branch"

    assert_text "Branch was successfully created"
    click_on "Back"
  end

  test "updating a Branch" do
    visit branches_url
    click_on "Edit", match: :first

    fill_in "Email manager", with: @branch.email_manager
    fill_in "Hour cl", with: @branch.hour_cl
    fill_in "Hour op", with: @branch.hour_op
    fill_in "Information", with: @branch.information
    fill_in "Instagram api token", with: @branch.instagram_api_token
    fill_in "Instagram", with: @branch.instagram_id
    fill_in "Name", with: @branch.name
    fill_in "Restaurant", with: @branch.restaurant_id
    fill_in "Street", with: @branch.street
    fill_in "Telephone", with: @branch.telephone
    fill_in "Telephone manager", with: @branch.telephone_manager
    fill_in "User", with: @branch.user_id
    click_on "Update Branch"

    assert_text "Branch was successfully updated"
    click_on "Back"
  end

  test "destroying a Branch" do
    visit branches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Branch was successfully destroyed"
  end
end