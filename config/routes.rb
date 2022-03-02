Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  get "/restricted", to: "pages#restricted" 
  # patch "/profile/:id", to: "pages#update_profile"
end
