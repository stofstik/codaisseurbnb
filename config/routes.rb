Rails.application.routes.draw do
  resources :themes
  get 'pages/home'

  devise_for :users

  root to: 'rooms#index'

  resources :users, only: [:show]
  resources :rooms do
    resources :bookings, only: [:create]
  end
  resources :profiles, only: [:new, :edit, :create, :update]
  resources :photos, only: [:destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
