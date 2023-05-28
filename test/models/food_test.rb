require "test_helper"

class FoodTest < ActiveSupport::TestCase
  def setup
    @food = Food.new(
      name: "Example Food",
      price: 9.99,
      restaurant: restaurants(:burger)
    )
  end

  test "should save food with valid attributes" do
    assert @food.save
  end

  test "should not save restaurant without name" do
    @food.name = ""
    assert_not @food.save
  end

  test 'should not save restaurant without price' do
    @food.price = nil
    assert_not @food.save
  end

  test "should not save restaurant with invalid price" do
    @food.price = 'invalid_price'
    assert_not @food.save
  end

  test "should belong to a restaurant" do
    assert_instance_of Restaurant, @food.restaurant
  end
end
