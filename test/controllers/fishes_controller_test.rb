require "test_helper"

class fishControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fish_index_url
    assert_response :success
  end
end
