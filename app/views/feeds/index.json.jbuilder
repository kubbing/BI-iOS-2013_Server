json.array!(@feeds) do |feed|
  json.extract! feed, :id, :message, :image
  json.account feed.account, :id
  json.profile feed.account.profile, :id, :nick
  json.url feed_url(feed, format: :json)
end
