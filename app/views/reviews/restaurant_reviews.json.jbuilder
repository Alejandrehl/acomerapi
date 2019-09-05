json.reviews @restaurant_reviews.each do |review|
    json.id review.id
    json.stars review.stars
    json.commentary review.commentary
end