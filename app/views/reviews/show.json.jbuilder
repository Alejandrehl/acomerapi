json.id @review.id
json.stars @review.stars
json.date @review.updated_at.strftime("%d/%m/%Y") 
json.commentary @review.commentary
json.user_name @review.user.name
json.product_name @review.product.name