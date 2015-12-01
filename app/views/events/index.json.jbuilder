json.array!(@events) do |event|
  json.extract! event, :id, :name, :from, :to, :user_id, :location, :longitude, :latitude, :hostedby, :description, :intereted, :going, :invited, :cover
  json.url event_url(event, format: :json)
end
