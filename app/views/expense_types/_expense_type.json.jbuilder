json.extract! expense_type, :id, :name, :active, :created_at, :updated_at
json.url expense_type_url(expense_type, format: :json)
