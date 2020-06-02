Rails.application.routes.draw do
  devise_for :users
  root to: 'scubos#index'
  resources :scubos, only: [:new, :create, :edit, :update]
end
