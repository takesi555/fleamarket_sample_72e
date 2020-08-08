Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
  
  root to: 'products#index'
  resources :users, only: [:show]
  resources :registration, only: [:index]
  resources :creditcards, only: [:show, :new, :create, :destroy]
  resources :categories, only: [:index]
  resources :items ,only: [:new, :create] do
    member do
      get 'confirm'
      post 'purchase'
      get 'complete'
    end
  end
end
