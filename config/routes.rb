Rails.application.routes.draw do

  # カード登録ルーティング
  resources :card, only: [:new, :show, :edit] do
  collection do
    post 'pay', to: 'card#pay'
    post 'delete', to: 'card#delete'
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
  resources :mypages, only: [:show,:edit] do
    collection do
      get 'logout'
      get 'status'
    end
  end
  resources :users, only: [:index,:new, :show, :edit, :update]
  resources :addresses, only: [:new, :create]
  resources :searches, only: [:index]
  # get '/searches/detail_search', to: 'searches#detail_search'

  resources :purchase, only: [:show] do
    collection do
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  post "/", to: "purchase#pay"
  resources :categories, only: :index do
  end

  root "items#index"
  resources :items, only: [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'image', defaults: { format: 'json' }
      get 'show_own'
      get 'show_buyer'
    end
    member do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'image', defaults: { format: 'json' }
    end
  end
end
