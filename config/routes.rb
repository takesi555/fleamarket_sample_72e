Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'

  resources :creditcards ,only: [:new,:create]
  resources :items do
    member do
      get 'confirm'
    end
  end
end
