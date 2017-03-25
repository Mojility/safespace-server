json.posts @posts do |post|
  json.(post, :id, :body)
  json.handle post.person.handle
end