json.extract! @comment, :id, :body, :created_at, :updated_at

json.stats do
  json.upvotes 0
  json.downvotes 0
end

json.meta do
  json.timeago timeago(@comment.created_at)
end

json.user do
  json.id @comment.user.id
  json.full_name @comment.user.full_name
  json.picture image_url(@comment.user.picture)
end

