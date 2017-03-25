Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # match 'registry' => 'application#register_user', via: [:post]
  # match 'registry/user/:id' => 'application#rooms_for_user', via: [:get]
  # match 'registry/subscribe' => 'application#join_room', via: [:post]
  # match 'posts/create' => 'application#create_post', via: [:post]

  match 'registry/user' => 'application#rooms', via: [:get]

  match 'auth/validate' => 'application#validate_invitation', via: [:post]
  match 'auth/setup' => 'application#setup_person', via: [:post]
  match 'auth/join' => 'application#join_room', via: [:post]
  match 'metadata' => 'application#metadata', via: [:post]
end
