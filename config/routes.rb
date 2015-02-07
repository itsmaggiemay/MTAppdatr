Rails.application.routes.draw do
  # get "map_display/index"
  get "sessions/create"
  get "tweets/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  # resource :tweets


end
