json.extract! menu, :id, :name, :description, :category, :branch_id, :created_at, :updated_at
json.url menu_url(menu, format: :json)
json.branches @branches
