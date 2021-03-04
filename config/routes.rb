Rails.application.routes.draw do
  resources :listings
  devise_for :users, controllers: { registrations: 'registrations' }

  root "listings#index"

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
end
