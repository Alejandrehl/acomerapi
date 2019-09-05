json.posts  @posts.each do |posts|
    
    json.id posts.id
    json.title posts.title
    json.content posts.content
    json.author posts.author
    json.image posts.image
    json.likes posts.likes
    json.user posts.user.name
    json.postcategory posts.post_category.name

end
