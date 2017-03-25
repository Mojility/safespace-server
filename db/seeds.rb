# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.delete_all
Room.delete_all
Membership.delete_all
Person.delete_all
Invitation.delete_all
Emote.delete_all
Post.delete_all
Infraction.delete_all
InfractionEvent.delete_all
EmoteEvent.delete_all


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Room.create!(name: 'Beauty from Ashes It\'s All About Us')
Room.create!(name: 'Gay Poz Guys')
Room.create!(name: 'Well Ahead')
r = Room.create!(name: 'The Pozzy')
p = Person.create!(email: 'coolio@gmail.io', handle: 'Coolio')
p.update_attribute(:auth, 'test')
Membership.create!(person: p, room: r)

Emote.create!(label: 'emote1', code: 'R')
Emote.create!(label: 'emote2', code: 'Q')
Emote.create!(label: 'emote3', code: 'W')
e = Emote.create!(label: 'emote4', code: 'E')

Infraction.create!(label: 'test infraction 2')
i = Infraction.create!(label: 'test infraction label')

post = Post.create!(person: p, room: r, body: ' body stuff 1')
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)
post = Post.create!(person: p, room: r, body: ' body stuff 2')
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)
post = Post.create!(person: p, room: r, body: ' body stuff 3')
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)
post = Post.create!(person: p, room: r, body: ' body stuff 4')
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)
post = Post.create!(person: p, room: r, body: ' body stuff 5')
post.infraction_events.create!(infraction: i, person: p)
post.emote_events.create!(emote: e, person: p)

