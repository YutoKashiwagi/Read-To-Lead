# frozen_string_literal: true

Rails.application.routes.draw do
  
  root 'static_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users,only: [:index,:show]
  get 'static_pages/help'
  get 'static_pages/contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
