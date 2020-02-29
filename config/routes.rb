Rails.application.routes.draw do
  # カード登録ルーティング
  resources :card, only: [:new, :edit, :show] do
  collection do
    post 'pay', to: 'card#pay'
    post 'delete', to: 'card#delete'
    get 'edit', to: 'card#edit'
  end
end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }


devise_scope :user do
  get 'addresses', to: 'users/registrations#new_address'
  get 'tmp_address', to: 'users/registrations#tmp_address'
  get 'edit_address', to: 'users/registrations#edit_address'
  post 'addresses', to: 'users/registrations#create_address'
  get 'sms_confirmation', to: 'users/registrations#sms_confirmation'
  get 'sms_recieved', to: 'users/registrations#sms_recieved'
  get 'register_credit_card', to: 'users/registrations#register_credit_card'
  post 'register_credit_card', to: 'users/registrations#register_credit_card'
  get 'complete', to: 'users/registrations#complete'

  # ここまで
end
  root "items#index"
  resources :mypages, only: [:show,:edit] do
    collection do
      get 'logout'
    end
  end
  resources :users, only: [:index,:new, :show, :edit, :update]
  resources :addresses, only: [:new, :create]
  # resources :items, only: [:show]
  resources :purchase, only: [:show] do
    collection do
      get 'show', to: 'purchase#show'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  post "/", to: "purchase#pay"
  # resources :items, only: [:show, :new, :create]
  # resources :purchase, only: [:show] 
  resources :items, only: [:show, :new, :create, :edit, :destroy] do
    collection do
      get 'get_image', defaults: { format: 'json' }
    end
  end
end
