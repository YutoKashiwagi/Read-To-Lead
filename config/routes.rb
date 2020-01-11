# frozen_string_literal: true

Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/contact'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  resources :users, only: [:index,:show,]
  resources :posts,  only: [:index,:show,:create,:destroy]

end
