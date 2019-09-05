json.categories  @categories.each do |categories|
    json.id categories.id
    json.name categories.name
    json.description categories.description
    json.user_id categories.user.name
end