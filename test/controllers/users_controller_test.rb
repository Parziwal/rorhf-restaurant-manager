require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
  end

  test "should get new" do
    get new_user_url
    assert_response :success
    assert_select "h1", "Registration"
  end

  test "should register user" do
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          name: "Test User",
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to root_url
    assert_equal "Successful registration", flash[:notice]
  end
  
  test "should throw unprocessable entity if user creation fails" do
    post users_url, params: {
      user: {
        name: "Test User",
        email: "test@example.com",
        password: "password",
        password_confirmation: "different_password"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {
      user: {
        name: "Updated Name",
        email: "updated@example.com"
      }
    }

    assert_redirected_to edit_user_url(@user)
    assert_equal "Successful update", flash[:notice]
    assert_equal "Updated Name", @user.reload.name
    assert_equal "updated@example.com", @user.reload.email
  end

  test "should throw unprocessable entity if user update fails" do
    patch user_url(@user), params: {
      user: {
        name: "",
        email: "updated@example.com"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should login user" do
    post login_users_url, params: { email: @user.email, password: "password" }
    assert_redirected_to root_url
    assert_equal "Successful login", flash[:notice]
    assert_equal @user.id, session[:user]

    follow_redirect!
    assert_select "a", "Logout"
  end

  test "should fail login if user credentials are invalid" do
    post login_users_url, params: { email: @user.email, password: "invalid_password" }
    assert_redirected_to new_user_url
    assert_equal "Login failed", flash[:notice]
  end

  test "should logout user" do
    post login_users_url, params: { email: @user.email, password: "password" }
    get logout_users_path
    assert_redirected_to new_user_url
    assert_equal "Successful logout", flash[:notice]
    assert_nil session[:user]

    follow_redirect!
    assert_select "div", "Login/Register"
  end
end
