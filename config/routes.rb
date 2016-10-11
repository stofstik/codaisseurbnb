Rails.application.routes.draw do
  resources :themes
  get 'pages/home'

  devise_for :users

  root to: 'pages#home'

  resources :users, only: [:show]
  resources :rooms
  resources :profiles, only: [:new, :edit, :create, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
