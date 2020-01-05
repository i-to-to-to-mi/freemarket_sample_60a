Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }


  get 'users/show'
  root "items#index"
  resources :users, :only => [:new, :show, :edit, :update]
  resources :addresses, :only => [:new, :create]
  
end
