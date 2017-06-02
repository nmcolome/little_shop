Rails.application.routes.draw do
  root 'items#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users, only: [:create, :new, :edit, :update]
  get '/dashboard', to: 'users#show'

  resources :items, only: [:show, :index]

  resources :categories, only: [:show]

  resources :carts, only: [:create, :index, :destroy, :update]

  namespace :admin do
    get '/dashboard', to: 'dashboards#index'
    resources :dashboards, only: [:show, :index, :edit]
    resources :items, only: [:index, :new, :create, :edit, :show, :update]
    resources :users, only: [:update, :show, :index]
  end
end
