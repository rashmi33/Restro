Rails.application.routes.draw do
  resources :restaurants
  resources :menus
  resources :orders
  resources :invoices
  resources :users
  root "welcomes#index"
end
