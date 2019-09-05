require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Branch", with: @order.branch_id
    check "Cart" if @order.cart
    fill_in "Cart type", with: @order.cart_type
    fill_in "Id cart", with: @order.id_cart
    fill_in "Menu", with: @order.menu_id
    fill_in "Products", with: @order.products
    fill_in "Request type", with: @order.request_type
    fill_in "Reservation", with: @order.reservation
    fill_in "Specification", with: @order.specification
    fill_in "Status", with: @order.status
    fill_in "Total", with: @order.total
    fill_in "Transaction", with: @order.transaction
    fill_in "User", with: @order.user_id
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Branch", with: @order.branch_id
    check "Cart" if @order.cart
    fill_in "Cart type", with: @order.cart_type
    fill_in "Id cart", with: @order.id_cart
    fill_in "Menu", with: @order.menu_id
    fill_in "Products", with: @order.products
    fill_in "Request type", with: @order.request_type
    fill_in "Reservation", with: @order.reservation
    fill_in "Specification", with: @order.specification
    fill_in "Status", with: @order.status
    fill_in "Total", with: @order.total
    fill_in "Transaction", with: @order.transaction
    fill_in "User", with: @order.user_id
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
