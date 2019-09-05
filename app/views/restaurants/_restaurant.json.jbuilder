json.extract! restaurant, :id, :name, :description, :business_name, :giro, :telephone, :email, :instagram, :facebook, :twitter, :pinterest, :tripadvisor, :user_id, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
json.categories @categories
json.branches @branches