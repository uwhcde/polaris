json.extract! @comment, :id, :body, :created_at, :updated_at

json.stats do
  json.upvotes 0
  json.downvotes 0
end

json.meta do
  json.timeago timeago(@comment.created_at)
  json.parent @comment.id
  json.url comments_path
  json.post_id @post.id
  json.post_type @post.class.to_s
end

json.user do
  json.id @comment.user.id
  json.full_name @comment.user.full_name
  json.picture image_url(@comment.user.picture)
end

