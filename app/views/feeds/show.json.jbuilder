json.extract! @feed, :id, :message, :latitude, :longitude, :image, :created_at, :updated_at
json.account @feed.account.profile, :nick
