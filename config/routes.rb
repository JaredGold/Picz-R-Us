Rails.application.routes.draw do
  resources :listings
  devise_for :users, skip: [:sessions]

  # Root to the listings page
  root  'listings#index'
  # profile shows user profile
  get   'profile',      to: 'profile#show',             as: 'profile'
  # post  'profile', to: 'profile#create'
  # edit profile allows users to edit their pre existing profile
  get   'profile/edit', to: 'profile#edit',             as: 'edit_profile'
  post  'profile/edit', to: 'profile#update'
  patch 'profile/edit',      to: 'profile#update'
  # new profile allows the user to create a new profile
  get   'profile/new',  to: 'profile#new',              as: 'new_profile'
  post  'profile/new',  to: 'profile#create'

  # Payments made successful or unsuccessful
  get   'payment/success', to: 'payments#success',      as: 'payment_success'
  post  'payments/webhook', to: 'payments#webhook'

  get   'payment/unsuccessful', to: 'payments#unsuccessful', as: 'payment_unsuccessful'
  
  # Set Devise Sign in/ sign up/ sign out routes
  as :user do
    get     'signin',   to: 'devise/sessions#new',      as: :new_user_session
    post    'signin',   to: 'devise/sessions#create',   as: :user_session
    delete  'signout',  to: 'devise/sessions#destroy',  as: :destroy_user_session
    get     'signup',   to: 'devise/registrations#new'
  end
end
