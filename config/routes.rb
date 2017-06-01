Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :users, only: [:show, :create, :new]

  resources :items, only: [:show]

  namespace :admin do
    resources :dashboards, only: [:show]
    resources :items, only: [:new, :create, :edit]
  end
end
