require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get show" do
    restaurant = restaurants(:burger)

    get home_url(restaurant)
    assert_response :success
  end
end
