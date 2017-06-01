Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  resources :users, only: [:index, :create]

  namespace :admin do
    resources :dashboards, only: [:show]
    resources :items, only: [:new, :create]
  end
end
