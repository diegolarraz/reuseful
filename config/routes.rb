Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :items do
    resources :comments, only: %w(new create destroy)
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
