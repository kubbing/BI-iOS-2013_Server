json.array!(@accounts) do |account|
  json.extract! account, :id, :login, :token
  json.profile account.profile, :id, :nick, :bio, :image, :latitude, :longitude
  json.url account_url(account, format: :json)
end
