Rails.application.routes.draw do
  get 'users/show'
  resources :products
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  resources :users, only: [:show]
  resources :sales, only: [:create, :index]
  root "products#index"
end
