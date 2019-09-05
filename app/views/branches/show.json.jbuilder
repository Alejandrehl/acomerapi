#json.partial! "branches/branch", branch: @branch
json.id @branch.id
json.restaurantname @branch.restaurant.name
json.name @branch.name
json.telephone @branch.telephone
json.address @branch.street
json.manageremail @branch.email_manager
json.managertelephone @branch.telephone_manager
json.info @branch.information
json.ophour @branch.hour_op
json.clhour @branch.hour_cl
json.branch_category @branch.branch_category
json.lat @branch.lat 
json.leng @branch.leng

if @branch.image_paths.present?  
    json.images @branch.image_paths.each do |img|
        json.src img.url
        json.thumb img.url
        json.caption @branch.name
    end
end


json.menus @branch.menus do |menu|	
    json.(menu, :id, :name)	
    # json.reviews_count menu.reviews.count(:id)	
    # json.reviews_prom menu.reviews.average(:stars)	
    json.img menu.img_url.present? ? menu.img_url : src="/img/logo.png"	
end

json.tables @branch.tables do |tables|
    json.(tables, :id, :description, :state)
end
