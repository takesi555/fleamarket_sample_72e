Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'

  resources :creditcards ,only: [:new,:create,:destroy]
  resources :items ,only: [:new, :create] do
    member do
      get 'confirm'
      post 'purchase'
    end
  end
end
