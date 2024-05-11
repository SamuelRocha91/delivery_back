Rails.application.routes.draw do
  devise_for :users
  resources :stores do
    resources :products
  end
  scope :buyers do
    resources :orders, only: [:index, :create, :update, :destroy]
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root to: "welcome#index"

  get "listing" => "products#listing"
  get "me" => "registrations#me"
  post "new" => "registrations#create", as: :create_registration
  post "sign_in" => "registrations#sign_in"
  get "up" => "rails/health#show", as: :rails_health_check
end
