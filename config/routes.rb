Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match 'registry/user' => 'application#rooms', via: [:get]
  match 'registry/user/:id' => 'application#rooms_for_user', via: [:get]
  match 'registry/subscribe' => 'application#join_room', via: [:post]

  match 'posts/create' => 'application#create_post', via: [:post]
end
