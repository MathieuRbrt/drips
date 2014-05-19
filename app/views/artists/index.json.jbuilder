json.array!(@artists) do |artist|
  json.extract! artist, :id, :name, :origin
  json.url artist_url(artist, format: :json)
end
