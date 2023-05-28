require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "John Doe",
      email: "john.doe@example.com",
      password: "password"
    )
  end

  test 'should save user with valid attributes' do
    assert @user.save
  end

  test "should not save user without name" do
    @user.name = ""
    assert_not @user.save
  end

  test "should not save user without email" do
    @user.email = ""
    assert_not @user.save
  end

  test "should not save user with existing email" do
    @user.email = users(:bob).email
    assert_not @user.save
  end

  test 'password should be confirmed if present' do
    @user.password_confirmation = 'different_password'
    assert_not @user.valid?
  end
end
