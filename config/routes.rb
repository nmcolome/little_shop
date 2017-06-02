Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :users, only: [:show, :create, :new, :edit, :update]

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
