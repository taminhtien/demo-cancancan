Rails.application.routes.draw do
  root 'pages#index'
  resources :sessions, only: [:update]
  resources :projects
end
