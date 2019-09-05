require 'test_helper'

class AdminCookAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_cook_account = admin_cook_accounts(:one)
  end

  test "should get index" do
    get admin_cook_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_cook_account_url
    assert_response :success
  end

  test "should create admin_cook_account" do
    assert_difference('AdminCookAccount.count') do
      post admin_cook_accounts_url, params: { admin_cook_account: { branch: @admin_cook_account.branch, id_admin: @admin_cook_account.id_admin, id_cook: @admin_cook_account.id_cook } }
    end

    assert_redirected_to admin_cook_account_url(AdminCookAccount.last)
  end

  test "should show admin_cook_account" do
    get admin_cook_account_url(@admin_cook_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_cook_account_url(@admin_cook_account)
    assert_response :success
  end

  test "should update admin_cook_account" do
    patch admin_cook_account_url(@admin_cook_account), params: { admin_cook_account: { branch: @admin_cook_account.branch, id_admin: @admin_cook_account.id_admin, id_cook: @admin_cook_account.id_cook } }
    assert_redirected_to admin_cook_account_url(@admin_cook_account)
  end

  test "should destroy admin_cook_account" do
    assert_difference('AdminCookAccount.count', -1) do
      delete admin_cook_account_url(@admin_cook_account)
    end

    assert_redirected_to admin_cook_accounts_url
  end
end
