Rails.application.routes.draw do
  root 'items#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users, only: [:create, :new, :edit, :update] do
    resources :orders, only: [:show]
  end
  get '/dashboard', to: 'users#show'

  resources :items, only: [:show, :index]

  resources :categories, only: [:show]

  resources :carts, only: [:create, :index, :destroy, :update]

  get 'admin/dashboard', to: 'admin/dashboard#show'

  namespace :admin do
    resources :dashboard, only: [:edit]
    resources :items, only: [:index, :new, :create, :edit, :show, :update]
    resources :users, only: [:update, :show, :index]
  end
end
