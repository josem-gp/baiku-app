Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'

  resources :parkings, except: [:edit, :update, :destroy] do
    resources :reviews, only: :create
  end

  resources :reviews, only: :update do
    resources :replies, only: :create
  end

  resources :users, only: [:edit, :update] do
    member do
      get :profile
    end
  end

  resources :parkings, only: [:index, :show] do
    member do
      post 'toggle_favorite', to: "parkings#toggle_favorite"
    end
  end

  resources :notifications, only: :index
end
