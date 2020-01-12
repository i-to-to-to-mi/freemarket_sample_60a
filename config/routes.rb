Rails.application.routes.draw do

  get 'users/show'
  devise_for :users
  root "items#index"
  resources :users, :only => [:show, :edit, :update]
  resources :addresses, :only => [:new, :create]
  resources :mypages
  
end
