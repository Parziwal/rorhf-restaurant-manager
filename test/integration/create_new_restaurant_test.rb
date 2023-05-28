require "test_helper"

class CreateNewRestaurantTest < ActionDispatch::IntegrationTest
  test "create new restaurant" do
    get new_user_url
    assert_response :success
    assert_select "input[type=submit][value='Login']"

    post login_users_url, params: { email: "bob@email.com", password: "password" }
    assert_redirected_to root_url
    assert_equal "Successful login", flash[:notice]
    assert_equal users(:bob).id, session[:user]
    follow_redirect!
    assert_select "a", "My restaurants"
    
    get restaurants_url
    assert_response :success
    assert_select "tr", 2

    post restaurants_url, params: {
        restaurant: {
          name: 'New Restaurant',
          address: '123 Main St',
          description: 'A new restaurant',
          user_id: users(:bob).id
        }
    }
    assert_redirected_to restaurants_path

    follow_redirect!
    assert_select "tr", 3

    get logout_users_path
    assert_redirected_to new_user_url
    assert_equal "Successful logout", flash[:notice]
    assert_nil session[:user]

    follow_redirect!
    assert_select "div", "Login/Register"
  end
end