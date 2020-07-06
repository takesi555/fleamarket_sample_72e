Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'

  resources :creditcards ,only: [:new,:create,:delete]
  resources :items do
    member do
      get 'confirm'
      post 'purchase'
    end
  end
  resources :items, only: [:new, :create]
end
