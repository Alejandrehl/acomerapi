require "application_system_test_case"

class RestaurantCategoriesTest < ApplicationSystemTestCase
  setup do
    @restaurant_category = restaurant_categories(:one)
  end

  test "visiting the index" do
    visit restaurant_categories_url
    assert_selector "h1", text: "Restaurant Categories"
  end

  test "creating a Restaurant category" do
    visit restaurant_categories_url
    click_on "New Restaurant Category"

    fill_in "Description", with: @restaurant_category.description
    fill_in "Name", with: @restaurant_category.name
    click_on "Create Restaurant category"

    assert_text "Restaurant category was successfully created"
    click_on "Back"
  end

  test "updating a Restaurant category" do
    visit restaurant_categories_url
    click_on "Edit", match: :first

    fill_in "Description", with: @restaurant_category.description
    fill_in "Name", with: @restaurant_category.name
    click_on "Update Restaurant category"

    assert_text "Restaurant category was successfully updated"
    click_on "Back"
  end

  test "destroying a Restaurant category" do
    visit restaurant_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Restaurant category was successfully destroyed"
  end
end
