json.extract! review, :id, :stars, :commentary, :user_id, :menu_id, :product_id, :created_at, :updated_at
json.url review_url(review, format: :json)
json.users @users
