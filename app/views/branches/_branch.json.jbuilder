json.extract! branch, :id, :name, :telephone, :street, :email_manager, :telephone_manager, :information, :hour_op, :hour_cl, :branch_category, :instagram_id, :instagram_api_token, :restaurant_id, :created_at, :updated_at
json.url branch_url(branch, format: :json)
json.images branch.images.each do |i|
    json.src url_for(i)
end 
json.menus @menus