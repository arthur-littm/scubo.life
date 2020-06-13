Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  root to: 'items#index'

  resources :items, only: [ :show, :new, :create, :edit, :update ] do
    get :map, on: :collection
    patch :update_published, on: :member
    resources :upvotes, only: [ :create ]
    resources :bookmarks, only: [ :create ]
  end

  get :my_account, to: 'users#my_account'
  get :saved, to: 'users#saved'
  get :pending, to: 'users#pending'
  get :archive, to: 'users#archive'

  resources :users, only: [ :edit, :update ]

  resources :upvotes, only: [ :destroy ]

  resources :bookmarks, only: [ :destroy ]

  resources :hashtags, only: [ :index ]

  post 'twilio/sms'
end
