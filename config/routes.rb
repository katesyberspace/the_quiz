Rails.application.routes.draw do
  resources :games_users
  resources :games
  resources :users

  get '/', to: 'pages#home'
  get '/login', to: 'sessions#new'

  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
