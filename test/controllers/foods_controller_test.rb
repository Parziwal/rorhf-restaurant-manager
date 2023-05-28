require "test_helper"

class FoodsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
    @restaurant = restaurants(:burger)
    @food = foods(:cheeseburger)
    post login_users_url, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get foods_url
    assert_response :success
  end

  test "should get new" do
    get new_food_url
    assert_response :success
  end

  test "should create food" do
    assert_difference("Food.count") do
      post foods_url, params: {
        food: {
          name: "New Food",
          price: 9.99,
          description: "A new food",
          restaurant_id: @restaurant.id
        }
      }
    end

    assert_redirected_to foods_path
  end

  test "should throw unprocessable entity if food creation fails" do
    post foods_url, params: {
      food: {
        name: "",
        price: 9.99,
        description: "A new food",
        restaurant_id: @restaurant.id
      }
    }

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_food_url(@food)
    assert_response :success
  end

  test "should update food" do
    patch food_url(@food), params: {
      food: {
        name: "Updated Food",
        price: 9.99,
        description: "Updated description"
      }
    }

    assert_redirected_to foods_path
    assert_equal "Updated Food", @food.reload.name
    assert_equal 9.99, @food.reload.price
    assert_equal "Updated description", @food.reload.description
  end

  test "should throw unprocessable entity if food update fails" do
    patch food_url(@food), params: {
      food: {
        name: "",
        price: 9.99,
        description: "Updated description"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should destroy food" do
    assert_difference("Food.count", -1) do
      delete food_url(@food)
    end

    assert_redirected_to foods_path
  end

  test "should redirect to foods path if accessing create, edit, or update with non-owned restaurant" do
    other_restaurant = restaurants(:pizza)
    other_food = foods(:margherita_pizza)

    post foods_url, params: {
      food: {
        name: "New Food",
        price: 9.99,
        description: "A new food",
        restaurant_id: other_restaurant.id
      },
    }
    assert_redirected_to foods_path
    assert_equal "Access denied", flash[:notice]

    patch food_url(other_food), params: {
      food: {
        name: "Updated Food",
        price: 9.99,
        description: "Updated description"
      }
    }
    assert_redirected_to foods_path
    assert_equal "Access denied", flash[:notice]
  end
end
