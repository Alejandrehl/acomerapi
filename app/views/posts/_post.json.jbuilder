json.extract! post, :id, :title, :content, :author, :image, :likes, :user_id, :post_category_id, :created_at, :updated_at
json.url post_url(post, format: :json)
json.users @users
json.post_categories @post_categories
