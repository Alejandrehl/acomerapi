json.tables @tables_per_branches.each do |table|
    json.id table.id
    json.description table.description
    json.state table.state
    json.assign table.assign
end