Rails.application.routes.draw do
  mount SseRailsEngine::Engine, at: '/sse'
  get '/games/:id/start', to: 'games#start'
  get "/games/live" => 'games#second_user_connected'
  post '/games/:id/finish/:score', to: 'games_users#update'
  
  resources :games_users
  resources :games
  resources :users

  get '/games/:id/finish', to: 'games_users#show'

  get '/', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/howtoplay', to: 'pages#howtoplay'
  get '/login', to: 'sessions#new'

  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
