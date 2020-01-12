# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: %i[index show] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: %i[create destroy]

  resources :posts, only: %i[index show create destroy] do
    resources :comments, only: [:create]
  end
end
