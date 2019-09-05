require 'test_helper'

class FeaturedBranchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get featured_branch_index_url
    assert_response :success
  end

end
