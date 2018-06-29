json.extract! user, :id, :name, :introduction, :address, :token, :bind_token, :created_at, :updated_at
json.url user_url(user, format: :json)
