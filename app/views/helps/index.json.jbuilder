json.array!(@helps) do |help|
  json.extract! help, :id, :title, :user_id, :location, :longitude, :latitude, :requiredby, :description, :cover, :date
  json.url help_url(help, format: :json)
end
