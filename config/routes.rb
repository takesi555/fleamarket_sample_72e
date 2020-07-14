Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  resources :items, only: [:new, :create]
end


