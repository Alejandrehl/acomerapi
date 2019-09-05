require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { activated: @product.activated, calories: @product.calories, carbohydrates: @product.carbohydrates, cost: @product.cost, description: @product.description, ingredient: @product.ingredient, name: @product.name, price: @product.price, proteins: @product.proteins, restaurant_id: @product.restaurant_id, saturated_fats: @product.saturated_fats, specialty: @product.specialty, unsaturated_fats: @product.unsaturated_fats, value_offer: @product.value_offer, vegan: @product.vegan, vegetarian: @product.vegetarian } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { activated: @product.activated, calories: @product.calories, carbohydrates: @product.carbohydrates, cost: @product.cost, description: @product.description, ingredient: @product.ingredient, name: @product.name, price: @product.price, proteins: @product.proteins, restaurant_id: @product.restaurant_id, saturated_fats: @product.saturated_fats, specialty: @product.specialty, unsaturated_fats: @product.unsaturated_fats, value_offer: @product.value_offer, vegan: @product.vegan, vegetarian: @product.vegetarian } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
