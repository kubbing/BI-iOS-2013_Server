json.array!(@accounts) do |account|
  json.extract! account, :id, :login, :nick, :token
  json.url account_url(account, format: :json)
end
