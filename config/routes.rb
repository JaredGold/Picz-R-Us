Rails.application.routes.draw do
  resources :listings
  devise_for :users, skip: [:sessions]

  root 'listings#index'
  
  get 'profile', to: 'profile#show', as: 'profile'

  get 'profile/new', to: 'profile#new', as: 'new_profile'
  post 'profile/new', to: 'profile#create'
  
  # Set Devise Sign in/ sign up/ sign out routes
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
    get 'signup', to: 'devise/registrations#new'
  end
end
