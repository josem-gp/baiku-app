Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :parkings, except: [:edit, :update, :destroy] do
    resources :reviews, only: :create
  end
  resources :reviews, only: :update do
    resources :replies, only: :create
  end
  resources :users, only: [:new, :update] do
    member do
      get :profile
    end
  end
end
