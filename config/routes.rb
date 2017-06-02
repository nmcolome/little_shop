Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :users, only: [:show, :create, :new]

  resources :items, only: [:show, :index]

  resources :categories, only: [:show]

  resources :carts, only: [:create, :index]

  namespace :admin do
    get '/dashboard', to: 'dashboards#index'
    resources :dashboards, only: [:show, :index]
    resources :items, only: [:index, :new, :create, :edit]
  end
end
