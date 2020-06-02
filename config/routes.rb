Rails.application.routes.draw do
  get 'scubos/index'
  get 'scubos/new'
  get 'scubos/edit'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
