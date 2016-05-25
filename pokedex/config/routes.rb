Rails.application.routes.draw do
  devise_for :users
  resources :moves
  resources :types
 root 'home#index'
 resources :pokemons
end
