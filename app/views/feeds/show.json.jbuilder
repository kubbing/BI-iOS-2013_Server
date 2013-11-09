json.extract! @feed, :id, :message, :image, :created_at, :updated_at
json.account @feed.account, :nick
