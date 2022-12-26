json.extract! user, :id, :email, :login, :password_digest, :favorite, :created_at, :updated_at
json.url user_url(user, format: :json)
