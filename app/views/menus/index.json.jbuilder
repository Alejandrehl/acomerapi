json.menus  @menus.each do |menu|
    json.id menu.id
    json.name menu.name
    json.description menu.description
    # json.reviews_count menu.reviews.count(:id)
    # json.reviews_prom menu.reviews.average(:stars)
    json.categories menu.categories.each do |cat|
        json.id cat.id
        json.name cat.name
        json.description cat.description
        json.products cat.products.each do |prod|
          if prod.activated
            json.id prod.id
            json.name prod.name
            json.description prod.description
            json.ingredients prod.ingredient
            json.price prod.price
            json.img prod.image_product_paths.present? ? prod.image_product_paths.first.url : src="/img/logo.png"
          end
        end
      end
    json.branch menu.branch.name
    json.img menu.img_url.present? ? menu.img_url : src="/img/logo.png"	
end

