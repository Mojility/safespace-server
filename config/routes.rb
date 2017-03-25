Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # match 'registry' => 'application#register_user', via: [:post]
  # match 'registry/user/:id' => 'application#rooms_for_user', via: [:get]
  # match 'registry/subscribe' => 'application#join_room', via: [:post]
  # match 'posts/create' => 'application#create_post', via: [:post]

  match 'registry/user' => 'api#rooms', via: [:get]

  match 'auth/validate' => 'api#validate_invitation', via: [:post]
  match 'auth/setup' => 'api#setup_person', via: [:post]
  match 'auth/join' => 'api#join_room', via: [:post]
  match 'metadata' => 'api#metadata', via: [:post]

  match 'room/:room_id' => 'api#get_posts', via: [:get]
  match 'room/:room_id/post' => 'api#post_post', via: [:post]
  match 'room/:room_id/post/:post_id/emote' => 'api#emote_on_post', via: [:post]
  match 'room/:room_id/post/:post_id/emote/:emote_id' => 'api#remove_emote_from_post', via: [:delete]
  match 'room/:room_id/post/:post_id/infraction' => 'api#callout', via: [:post]
  match 'room/:room_id/post/:post_id/infraction/:infraction_id' => 'api#remove_callout', via: [:delete]

  match 'room/:room_id/infraction' => 'api#create_infraction', via: [:post]
  match 'room/:room_id/infraction/rate' => 'api#rate_infraction', via: [:post]
end
