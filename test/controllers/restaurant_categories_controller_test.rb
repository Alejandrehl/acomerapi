require 'test_helper'

class RestaurantCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant_category = restaurant_categories(:one)
  end

  test "should get index" do
    get restaurant_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_category_url
    assert_response :success
  end

  test "should create restaurant_category" do
    assert_difference('RestaurantCategory.count') do
      post restaurant_categories_url, params: { restaurant_category: { description: @restaurant_category.description, name: @restaurant_category.name } }
    end

    assert_redirected_to restaurant_category_url(RestaurantCategory.last)
  end

  test "should show restaurant_category" do
    get restaurant_category_url(@restaurant_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_category_url(@restaurant_category)
    assert_response :success
  end

  test "should update restaurant_category" do
    patch restaurant_category_url(@restaurant_category), params: { restaurant_category: { description: @restaurant_category.description, name: @restaurant_category.name } }
    assert_redirected_to restaurant_category_url(@restaurant_category)
  end

  test "should destroy restaurant_category" do
    assert_difference('RestaurantCategory.count', -1) do
      delete restaurant_category_url(@restaurant_category)
    end

    assert_redirected_to restaurant_categories_url
  end
end
