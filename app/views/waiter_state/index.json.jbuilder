json.waitercall  @waiterstate.each do |waiterstate|
    json.id waiterstate.id
    json.reason waiterstate.reason
    json.table_id waiterstate.table_id
end