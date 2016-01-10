json.votes do
  json.upvotes @comment.get_upvotes.size
  json.downvotes @comment.get_downvotes.size
  json.post_id @comment.id
end
