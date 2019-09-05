json.products  @products.each do |product|
    json.id product.id
    json.name product.name
    json.description product.description
    json.price product.price
    json.cost product.cost
    json.ingredient product.ingredient
    json.calories product.calories
    json.proteins product.proteins
    json.carbohydrates product.carbohydrates
    json.saturated_fats product.saturated_fats
    json.unsaturated_fats product.unsaturated_fats
    json.vegan product.vegan
    json.vegetarian product.vegetarian
    json.specialty product.specialty
    json.activated product.activated
    json.value_offer product.value_offer
    json.user_name product.user.name
    json.reviews_count product.reviews.count(:id)
    json.reviews_prom product.reviews.average(:stars)
    json.img product.image_product_paths.present? ? product.image_product_paths.first.url : src="/img/logo.png"


    json.categories product.categories do |cat|
        json.(cat, :id, :name)
    end

    json.reviews product.reviews do |reviews|
        json.(reviews, :id, :stars, :date, :commentary)
        json.user_id reviews.user.id
        json.user_name reviews.user.name
        json.user_img reviews.user.profile.attached? ? polymorphic_url(reviews.user.profile) : src="/img/logo.png"
    end

end