json.bookmark do
  json.bookmark @event.reputation_for(:bookmark)
  json.post_id @event.id
end
