json.rooms @rooms do |r|
  json.(r, :id, :name)
end

json.emotes @emotes do |e|
  json.(e, :id, :label, :code)
end