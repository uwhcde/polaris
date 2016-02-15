json.bookmark do
  json.bookmark @guide.reputation_for(:bookmark)
  json.post_id @guide.id
end
