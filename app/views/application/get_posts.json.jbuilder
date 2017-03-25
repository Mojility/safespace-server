json.posts @posts do |post|
  json.(post, :id, :body)
  json.handle post.person.handle
  json.emotes post.emotes do |emote|
    json.id emote[:id]
    json.quantity emote[:quantity]
  end
  json.infractions post.infractions do |infraction|
    json.id infraction[:id]
    json.quantity infraction[:quantity]
  end
end