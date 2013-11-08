json.array!(@feeds) do |feed|
  json.extract! feed, :id, :author, :message, :image
  json.url feed_url(feed, format: :json)
end
