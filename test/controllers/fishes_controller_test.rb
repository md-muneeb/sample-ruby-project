require "test_helper"

class FishesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fishes_index_url
    assert_response :success
  end
end
