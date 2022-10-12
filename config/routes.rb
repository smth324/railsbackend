Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "users#index"

  resources :users
  resources :stores
  resources :items
  resources :categories
  resources :types

  # Defines the root path route ("/")
  # root "articles#index"
end
