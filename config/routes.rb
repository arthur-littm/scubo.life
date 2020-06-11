Rails.application.routes.draw do
  get 'users/my_account'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  root to: 'items#index'
  resources :items, only: [ :show, :new, :create, :edit, :update, :index ] do
    get :map, on: :collection
    resources :upvotes, only: [ :create ]
  end

  get :my_account, to: 'users#my_account'

  resources :upvotes, only: [ :destroy ]
  resources :hashtags, only: [ :index ]
  post 'twilio/sms'
end
