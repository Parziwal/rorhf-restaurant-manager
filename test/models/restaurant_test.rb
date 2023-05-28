require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.new(
      name: "Example Restaurant",
      address: "123 Main St",
      user: users(:bob)
    )
  end

  test "should save restaurant with valid attributes" do
    assert @restaurant.save
  end

  test "should not save restaurant without name" do
    @restaurant.name = ""
    assert_not @restaurant.save
  end

  test "should not save restaurant with existing name" do
    @restaurant.name = restaurants(:burger).name
    assert_not @restaurant.save
  end

  test "should not save restaurant without address" do
    @restaurant.address = ""
    assert_not @restaurant.save
  end

  test "should belong to a user" do
    assert_instance_of User, @restaurant.user
  end
end
