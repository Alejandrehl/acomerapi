require 'test_helper'

class PagosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pagos_index_url
    assert_response :success
  end

end
