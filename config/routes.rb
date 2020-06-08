Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: 'items#index'
  resources :items, only: [:new, :create, :edit, :update, :index] do
    get :map, on: :collection
  end
  resources :hashtags, only: [ :index ]
end
