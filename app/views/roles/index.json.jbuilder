json.roles  @role.each do |rol|
    json.id rol.id
    json.name rol.name
    json.users rol.users do |user|
        json.(user, :id, :name)
    end
end
