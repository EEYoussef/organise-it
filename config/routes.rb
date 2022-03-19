Rails.application.routes.draw do

  
  
  
  devise_for :users , :controllers => { registrations: 'users/registrations' }
  
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
  
  # to list all offers for a certain project
  get "projects/:project_id/offers", to: "offers#offers_list", as: "offers_list"
  get "payments/success/:id", to: "payments#success", as: "payments_success"
  post "payments/webhook", to: "payments#webhook"
  post "payments", to: "payments#create_payment_intent", as: "create_payment_intent"
  
# for offers
  resources :offers ,only: [:show,:index]
  get "o/:id", to: "offers#freelancer_show" ,as:"freelancer_offer" 
# for Users
resources :users, only: [:index, :show, :edit, :update]

# for job outcomes
resources :projects do
  resources :project_outcomes, only: [:index, :new,:create,:show , :edit, :update]
end

# for offers related to project
resources :projects do
  resources :offers , only: [ :new, :create, :edit, :update] 
end

end
