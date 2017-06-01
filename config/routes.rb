Rails.application.routes.draw do

  get '/login', to: 'sessions#new'

  resources :users, only: [:index, :create]

  resources :items, only: [:show]

  namespace :admin do
    resources :dashboards, only: [:show]
    resources :items, only: [:new, :create, :edit]
  end
end
