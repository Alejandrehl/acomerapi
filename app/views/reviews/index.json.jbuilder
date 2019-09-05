json.reviews  @reviews.each do |review|
    json.id review.id
    json.stars review.stars
    json.commentary review.commentary
    json.user_name review.user.name
    json.product_name review.product.name
end