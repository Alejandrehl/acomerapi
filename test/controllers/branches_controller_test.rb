require 'test_helper'

class BranchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @branch = branches(:one)
  end

  test "should get index" do
    get branches_url
    assert_response :success
  end

  test "should get new" do
    get new_branch_url
    assert_response :success
  end

  test "should create branch" do
    assert_difference('Branch.count') do
      post branches_url, params: { branch: { email_manager: @branch.email_manager, hour_cl: @branch.hour_cl, hour_op: @branch.hour_op, information: @branch.information, instagram_api_token: @branch.instagram_api_token, instagram_id: @branch.instagram_id, name: @branch.name, restaurant_id: @branch.restaurant_id, street: @branch.street, telephone: @branch.telephone, telephone_manager: @branch.telephone_manager, user_id: @branch.user_id } }
    end

    assert_redirected_to branch_url(Branch.last)
  end

  test "should show branch" do
    get branch_url(@branch)
    assert_response :success
  end

  test "should get edit" do
    get edit_branch_url(@branch)
    assert_response :success
  end

  test "should update branch" do
    patch branch_url(@branch), params: { branch: { email_manager: @branch.email_manager, hour_cl: @branch.hour_cl, hour_op: @branch.hour_op, information: @branch.information, instagram_api_token: @branch.instagram_api_token, instagram_id: @branch.instagram_id, name: @branch.name, restaurant_id: @branch.restaurant_id, street: @branch.street, telephone: @branch.telephone, telephone_manager: @branch.telephone_manager, user_id: @branch.user_id } }
    assert_redirected_to branch_url(@branch)
  end

  test "should destroy branch" do
    assert_difference('Branch.count', -1) do
      delete branch_url(@branch)
    end

    assert_redirected_to branches_url
  end
end
