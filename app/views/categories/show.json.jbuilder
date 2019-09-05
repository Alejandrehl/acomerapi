#json.partial! "categories/category", category: @category
json.id @category.id
json.name @category.name
json.description @category.description
json.user_id @category.user.name
