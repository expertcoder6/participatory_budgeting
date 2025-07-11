Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "budget_categories#index"

  resources :budget_categories, only: [:index, :show]
  resources :budget_proposals, only: [:new, :create]
  resources :votes, only: [:new, :create]

  get "pages/home", to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
end
