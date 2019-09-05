json.branches  @branches.each do |branch|
    json.id branch.id
    json.restaurantname branch.restaurant.name
    json.name branch.name
    json.telephone branch.telephone
    json.address branch.street
    json.manageremail branch.email_manager
    json.managertelephone branch.telephone_manager
    json.info branch.information
    json.ophour branch.hour_op
    json.clhour branch.hour_cl
    json.branch_category branch.branch_category

    json.img branch.image_paths.present? ? branch.image_paths.first.url : src="/img/logo.png"


    json.table branch.tables do |tables|
        json.(tables, :id, :description, :state)
    end

end