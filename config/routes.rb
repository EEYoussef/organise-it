Rails.application.routes.draw do

  
  devise_for :users
  
  root to: "pages#home"
  
  # For Project
  get "projects", to: "projects#index", as: "projects"
  post "projects", to: "projects#create"
  get "projects/new", to: "projects#new", as: "new_project"
  get "projects/:id", to: "projects#show", as: "project"
  put "projects/:id", to: "projects#update"
  patch "projects/:id", to: "projects#update"
  delete "projects/:id", to: "projects#destroy", as: "delete_project"
  get "projects/:id/edit", to: "projects#edit", as: "edit_project"
  
  
  
  # get "payments/success/:id", to: "payments#success", as: "payments_success"
  # post "payments/webhook", to: "payments#webhook"

resources :offers ,only: [:show,:index]
resources :users, only: [:index, :show, :edit, :update]

resources :projects do
  resources :offers , only: [ :new, :create, :update] 
end
# to list all offers for a certain project
get "projects/:project_id/offers", to: "offers#offers_list", as: "offers_list"

end
