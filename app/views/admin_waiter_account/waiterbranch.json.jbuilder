json.waiters @waiters.each do |waiters|
    json.id waiters.id
    json.name waiters.name
    json.email waiters.email
end