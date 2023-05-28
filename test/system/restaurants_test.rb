require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
    test "visiting the index" do
        visit new_user_url

        fill_in "Email", with: users(:bob).email, :match => :prefer_exact
        fill_in "Password", with: "password", :match => :prefer_exact
        click_on "Login"

        visit restaurants_url
        assert_selector "h1", text: "My restaurants"
        assert_selector "tr", count: 2
    end

    test "should create restaurant" do
        visit new_user_url

        fill_in "Email", with: users(:bob).email, :match => :prefer_exact
        fill_in "Password", with: "password", :match => :prefer_exact
        click_on "Login"

        visit restaurants_url
        click_on "New restaurant"

        fill_in "Name", with: "Test Restaurant"
        fill_in "Address", with: "Test street 1"
        fill_in "Description", with: "Test Description"
        click_on "Create Restaurant"

        assert_text "Test Restaurant"
    end
end
