Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }, skip: [:registrations]

    get 'sign_up', to: 'registrations#new', as: :sign_up_registration
    post 'sign_up' => 'registrations#create'
    get 'users' => 'registrations#index'
    resources :registrations, only: [:edit, :update]
    put 'users/:id/reactivate', to: 'registrations#reactivate', as: 'reactivate_user'
    delete "deactivate_user/:id", to: "registrations#deactivate_user", as: :deactivate_user

  resources :stores do
    resources :products
    member do
      put 'reactivate_store', to: 'stores#reactivate', as: :reactivate_store
      put 'reactivate_product', to: 'products#reactivate', as: :reactivate_product
    end
  end

  scope :buyers do
    resources :orders, only: [:index, :create, :update, :destroy]
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount ActionCable.server => '/cable'

  root to: "welcome#index"

  get "listing", to: "products#listing"
  get "me", to: "registrations#me"
  post "new", to: "registrations#create", as: :create_registration
  post "sign_in", to: "registrations#sign_in"

  get "up", to: "rails/health#show", as: :rails_health_check
  
  match "*path", to: redirect("/"), via: :all
end

