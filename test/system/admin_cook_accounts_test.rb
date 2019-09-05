require "application_system_test_case"

class AdminCookAccountsTest < ApplicationSystemTestCase
  setup do
    @admin_cook_account = admin_cook_accounts(:one)
  end

  test "visiting the index" do
    visit admin_cook_accounts_url
    assert_selector "h1", text: "Admin Cook Accounts"
  end

  test "creating a Admin cook account" do
    visit admin_cook_accounts_url
    click_on "New Admin Cook Account"

    fill_in "Branch", with: @admin_cook_account.branch
    fill_in "Id admin", with: @admin_cook_account.id_admin
    fill_in "Id cook", with: @admin_cook_account.id_cook
    click_on "Create Admin cook account"

    assert_text "Admin cook account was successfully created"
    click_on "Back"
  end

  test "updating a Admin cook account" do
    visit admin_cook_accounts_url
    click_on "Edit", match: :first

    fill_in "Branch", with: @admin_cook_account.branch
    fill_in "Id admin", with: @admin_cook_account.id_admin
    fill_in "Id cook", with: @admin_cook_account.id_cook
    click_on "Update Admin cook account"

    assert_text "Admin cook account was successfully updated"
    click_on "Back"
  end

  test "destroying a Admin cook account" do
    visit admin_cook_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admin cook account was successfully destroyed"
  end
end
