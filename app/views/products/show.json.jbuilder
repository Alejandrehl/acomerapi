json.id @product.id
json.name @product.name
json.description @product.description
json.price @product.price
json.ingredient @product.ingredient
json.calories @product.calories
json.activated @product.activated
json.offer_activated @product.offer_activated
json.proteins @product.proteins
json.carbohydrates @product.carbohydrates
json.saturated_fats @product.saturated_fats
json.unsaturated_fats @product.unsaturated_fats
json.vegan @product.vegan
json.vegetarian @product.vegetarian
json.specialty @product.specialty
json.value_offer @product.value_offer
# json.reviews_count @reviews.count
# json.reviews_prom @reviews.average(:stars)


json.img @product.image_product_paths.present? ? @product.image_product_paths.first.url : src="/img/logo.png"
if @product.image_product_paths.present?  
    json.images @product.image_product_paths.each do |img|
        json.url img.url
    end
end

json.comentaries @product.reviews do |reviews|
    json.(reviews, :id, :stars, :commentary)
    # .strftime("%d/%m/%Y") 
    json.user_id reviews.user.id
    json.user_name reviews.user.name
    json.user_img reviews.user.profile.attached? ? polymorphic_url(reviews.user.profile) : src="/img/logo.png"
end