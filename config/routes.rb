Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  resources :items do
    member do
      get 'confirm'
    end
  end
end
