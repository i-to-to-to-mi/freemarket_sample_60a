Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
devise_scope :user do
  get 'addresses', to: 'users/registrations#new_address'
  get 'edit_address', to: 'users/registrations#edit_address'
  post 'addresses', to: 'users/registrations#create_address'
  # マークアップ用temporary routesです。ここから
  get 'sms_confirmation', to: 'users/registrations#sms_confirmation'
  get 'sms_recieved', to: 'users/registrations#sms_recieved'
  get 'tmp_register_credit_card', to: 'users/registrations#tmp_register_credit_card'
  get 'complete', to: 'users/registrations#complete'
  get 'register_address', to: 'users/registrations#register_address'
  # ここまで
end
  root "items#index"
  resources :mypages, only: [:show]
  resources "mypages",only: :logout, path: '' do
    collection do
      get 'logout'
    end
  end
  get 'users/show'
  resources :users, only: [:index,:new, :show, :edit, :update]
  resources :addresses, only: [:new, :create]
  resources :purchase, only: [:show] 
  resources :items, only: [:show, :new, :create]
end
