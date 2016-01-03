json.votes do
  json.upvotes @guide.get_upvotes.size
  json.downvotes @guide.get_downvotes.size
  json.post_id @guide.id
end
