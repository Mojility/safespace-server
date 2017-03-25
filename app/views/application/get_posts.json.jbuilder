json.posts @posts do |post|
  json.(post, :id, :body)
  json.handle post.person.handle
  json.emotes post.emote_events do |emote|
    json.id emote.emote.id
    json.quantity 5
  end
  json.infractions post.infraction_events do |infraction|
    json.id infraction.infraction.id
    json.quantity 5
  end
end