Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }, skip: [:registrations]

  authenticated :user do
    get 'sign_up', to: 'registrations#new', as: :sign_up_registration
    post 'sign_up' => 'registrations#create'
    get 'users' => 'registrations#index'
    resources :registrations, only: [:edit, :update]
    put '/users/:id/reactivate', to: 'registrations#reactivate', as: 'reactivate_user'
    delete "deactivate_user/:id" => "registrations#deactivate_user", as: :deactivate_user
  end

  resources :stores do
    resources :products
  end
  scope :buyers do
    resources :orders, only: [:index, :create, :update, :destroy]
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount ActionCable.server => '/cable '

  root to: "welcome#index"

  get "listing" => "products#listing"
  get "me" => "registrations#me"
  post "new" => "registrations#create", as: :create_registration
  post "sign_in" => "registrations#sign_in"

  get "up" => "rails/health#show", as: :rails_health_check
  match "*path", to: redirect("/"), via: :all

end
