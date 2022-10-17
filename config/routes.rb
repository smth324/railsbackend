Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "users#index"

  get "/users/signout", to: "users#signout"
  resources :users
  resources :stores
  resources :items
  resources :categories
  resources :types

  # Defines the root path route ("/")
  # root "articles#index"
end
