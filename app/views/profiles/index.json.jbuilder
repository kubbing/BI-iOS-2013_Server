json.array!(@profiles) do |profile|
  json.extract! profile, :id, :nick, :bio, :image, :latitude, :longitude, :updated_at
  json.url profile_url(profile, format: :json)
end
