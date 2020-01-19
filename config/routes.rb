Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
devise_scope :user do
  get 'addresses', to: 'users/registrations#new_address'
  get 'yazawa', to: 'users/registrations#yazawa'
  post 'addresses', to: 'users/registrations#create_address'
end
  root "items#index"
  get 'users/show'
  resources :users, only: [:index,:new, :show, :edit, :update]
  resources :addresses, only: [:new, :create]
end
