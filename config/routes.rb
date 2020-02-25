Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :items do
    resources :comments, only: %w(new create)
    resources :exchanges, only: %w(new create)
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :comments, only: [:destroy]
  resources :exchanges, only: [:destroy]
end
