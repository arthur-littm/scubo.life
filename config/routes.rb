Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: 'scubos#index'
  resources :scubos, only: [:new, :create, :edit, :update]
end
