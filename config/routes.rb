Rails.application.routes.draw do
  root 'items#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:create, :new]
  get '/dashboard', to: 'users#show'

  resources :items, only: [:show, :index]

  resources :categories, only: [:show]

  resources :carts, only: [:create, :index, :destroy, :update]

  namespace :admin do
    get '/dashboard', to: 'dashboards#index'
    resources :dashboards, only: [:show, :index]
    resources :items, only: [:index, :new, :create, :edit, :show, :update]
  end
end
