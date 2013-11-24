json.extract! @account, :id, :login, :token, :created_at, :updated_at
json.profile @account.profile, :id, :nick, :bio, :image, :latitude, :longitude
