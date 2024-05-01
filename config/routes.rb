Rails.application.routes.draw do
  devise_for :users
  resources :stores
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root to: "welcome#index"

  get "listing" => "products#listing"
  get "me" => "registrations#me"
  post "new" => "registrations#create", as: :create_registration
  get "up" => "rails/health#show", as: :rails_health_check

end
