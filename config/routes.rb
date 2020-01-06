Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
# Devise::RegistrationsControllerを継承した、Users::RegistrationsControllerを作成したイメージ
devise_scope :user do
  get 'addresses', to: 'users/registrations#new_address'
  post 'addresses', to: 'users/registrations#create_address'
end
# ここのroot遷移先がログインor新規登録を選ぶページになる必要があるので後ほど調整必要です
  root "items#index"
  get 'users/show'
  resources :users, only: [:new, :show, :edit, :update]
  resources :addresses, only: [:new, :create]
  
end
