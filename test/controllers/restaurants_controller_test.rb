require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
    @restaurant = restaurants(:burger)
    post login_users_url, params: { email: @user.email, password: "password" }
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference("Restaurant.count") do
      post restaurants_url, params: {
        restaurant: {
          name: 'New Restaurant',
          address: '123 Main St',
          description: 'A new restaurant',
          user_id: @user.id
        }
      }
    end

    assert_redirected_to restaurants_path
  end

  test "should throw unprocessable entity if restaurant creation fails" do
    post restaurants_url, params: {
      restaurant: {
        name: "",
        address: "123 Main St",
        description: "A new restaurant",
        user_id: @user.id
      }
    }

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: {
      restaurant: {
        name: "Updated Restaurant",
        address: "456 Elm St",
        description: "Updated description"
      }
    }

    assert_redirected_to restaurants_path
    assert_equal "Updated Restaurant", @restaurant.reload.name
    assert_equal "456 Elm St", @restaurant.reload.address
    assert_equal "Updated description", @restaurant.reload.description
  end

  test "should throw unprocessable entity if restaurant update fails" do
    patch restaurant_url(@restaurant), params: {
      restaurant: {
        name: "",
        address: "456 Elm St",
        description: "Updated description"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should destroy restaurant" do
    assert_difference("Restaurant.count", -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_path
  end

  test "should redirect to restaurants path if accessing edit or update of non-owned restaurant" do
    restaurant = restaurants(:pizza)

    get edit_restaurant_url(restaurant)
    assert_redirected_to restaurants_path
    assert_equal "Access denied", flash[:notice]

    patch restaurant_url(@restaurant), params: {
      restaurant: {
        name: "Updated Restaurant",
        address: "456 Elm St",
        description: "Updated description"
      }
    }
    assert_redirected_to restaurants_path
    assert_equal "Access denied", flash[:notice]
  end
end
