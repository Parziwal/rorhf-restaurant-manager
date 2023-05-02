Rails.application.routes.draw do
  root 'home#index'
  resources :home
  resources :restaurants
  resources :foods
  resources :users do
    post :login, on: :collection
    get :logout, on: :collection
  end
end
