    json.id @reserve.id
    json.qr @qr
    json.mode @reserve.mode
    json.branch @reserve.order.branch.name
    json.reservation_day @reserve.reservation_day.strftime("%d/%m/%Y")
    json.reservation_hour @reserve.reservation_hour.strftime("%H:%M")
    json.number_people @reserve.number_people
    json.user @reserve.user
    json.order @reserve.order
    json.orderproducts @reserve.order.order_details.each do |od|
        json.product od.product.name
        json.quantity od.quantity
    end
