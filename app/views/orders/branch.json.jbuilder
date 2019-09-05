json.orders @orders_per_branches.each do |order|
    json.id order.id
    json.hour order.created_at
    json.products order.order_details.each do |odetail|
        json.name odetail.product.name
        json.quantity odetail.quantity
        json.price odetail.product.price
    end
    json.total order.total
    json.status order.status
    json.specification order.specification
    json.reservation order.reservation
    json.user_name order.user.name
    json.menu_name order.branch.name
    json.table_id order.tables_id
    json.payed order.payed
    json.payment_method order.payment_method
    json.payment_modality order.payment_modality
    json.branch_id order.branch_id
end