json.orders  @orders.each do |order|
    json.id order.id
    json.total order.total
    json.status order.status
    json.specification order.specification
    json.reservation order.reservation
    json.user_name order.user.name
    json.menu_name order.branch
    json.payment_method order.payment_method
    json.products order.products
end