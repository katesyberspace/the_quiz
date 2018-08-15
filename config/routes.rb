Rails.application.routes.draw do
  mount SseRailsEngine::Engine, at: '/sse'
  get '/games/:id/start', to: 'games#start'
  get "/games/live" => 'games#second_user_connected'

  resources :games_users
  resources :games
  resources :users

  put '/games/:id/finish', to: 'games_users#update'
  get '/games/:id/finish', to: 'games_users#show'

  get '/', to: 'pages#home'
  get '/login', to: 'sessions#new'

  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
