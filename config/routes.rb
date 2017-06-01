Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :users, only: [:show, :create, :new]

  resources :items, only: [:show, :index]

  resources :categories, only: [:show]

  resources :carts, only: [:create, :index, :destroy]

  namespace :admin do
    resources :dashboards, only: [:show]
    resources :items, only: [:new, :create, :edit]
  end
end
