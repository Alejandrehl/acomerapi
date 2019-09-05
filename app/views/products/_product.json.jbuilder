json.extract! product, :id, :name, :description, :price, :cost, :ingredient, :calories, :proteins, :carbohydrates, :saturated_fats, :unsaturated_fats, :vegan, :vegetarian, :specialty, :activated, :value_offer , :offer_activated, :created_at, :updated_at
json.images product.images.each do |i|
  json.image url_for(i)
end
json.url product_url(product, format: :json)

json.comentaries @comentarios
json.users @users
json.reviews @reviews