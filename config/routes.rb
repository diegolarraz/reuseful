Rails.application.routes.draw do
  root to: 'pages#home'
  get '/profile', to: 'pages#profile'
  get '/profile/:exchange', to: 'pages#confirm?', as: 'confirm'
  devise_for :users
  # shortcut for all the routes (show, edit, update, new, etc.)
  resources :items do
    # shortcut for => get "/items/:item_id/comments/new"
    resources :comments, only: [:new, :create]
    resources :exchanges, only: [:new, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :comments, only: [:destroy]
  resources :exchanges, only: [:destroy]
end
