json.array!(@guides) do |guide|
  json.extract! guide, :id, :title, :body
  json.url guide_url(guide, format: :json)
end
