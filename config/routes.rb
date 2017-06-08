Rails.application.routes.draw do
  root 'items#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users, only: [:create, :new, :edit, :update] do
    resources :orders, only: [:show, :create]
  end
  get '/orders', to: 'orders#index'
  get '/dashboard', to: 'users#show'

  resources :items, only: [:show, :index]

  resources :categories, only: [:show, :new, :index, :create]

  resources :carts, only: [:create, :index, :destroy, :update]

  get 'admin/dashboard', to: 'admin/dashboard#show'
  put 'admin/dashboard', to: 'admin/dashboard#update'

  namespace :admin do
    resources :dashboard, only: [:edit]
    resources :items, only: [:new, :create, :edit, :update]
    resources :users, only: [:update, :show, :index]
  end
end
