json.featured  @featuredbranches.each do |fbranch|
    json.id fbranch.id
    json.name fbranch.branch.name
    json.description fbranch.description
    json.img  fbranch.branch.images.attached? ? polymorphic_url(fbranch.branch.images.first) : src="/img/logo.png"
end

