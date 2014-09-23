json.array!(@users) do |user|
  json.extract! user, :id, :provider, :uid, :name, :email, :oauth_token, :oauth_expires_at, :role_id, :my_role_id, :enable
  json.url user_url(user, format: :json)
end
