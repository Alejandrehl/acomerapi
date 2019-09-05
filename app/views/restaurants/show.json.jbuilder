json.id @restaurant.id
json.name @restaurant.name
json.description @restaurant.description
json.category "nil"
json.stars "4"
json.business_name @restaurant.business_name
json.giro @restaurant.giro
json.images restaurant.image
json.telephone @restaurant.telephone
json.email @restaurant.email
json.instagram @restaurant.instagram
json.facebook @restaurant.facebook
json.twitter @restaurant.twitter
json.pinterest @restaurant.pinterest
json.tripadvisor @restaurant.tripadvisor
json.user_id @restaurant.user_id
json.branch @restaurant.branches do |branch|
    json.(branch, :id, :name)
    json.img branch.image_paths.present? ? branch.image_paths.first.url : src="/img/logo.png"
end