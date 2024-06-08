Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }, skip: [:registrations]
    get "/stores/listing", to: "stores#listing"
    get "/stores/:store_id/products/listing", to: "products#listing_within_token"


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

   resources :credentials, only: [:index, :create, :update] 
   delete '/credentials/:id', to: 'credentials#destroy', as: 'delete_credential'

    
  scope :buyers do
    resources :orders, only: [:index, :create, :update, :destroy] do
      member do
        put 'pay'
        put 'confirm_payment'
        put 'payment_failed'
        put 'accept'
        put 'start_progress'
        put 'ready_for_delivery'
        put 'start_delivery'
        put 'deliver'
        put 'cancel'
      end
    end
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount ActionCable.server => '/cable'

  direct :rails_blob do |blob|
    route_for(:rails_service_blob, blob.signed_id, blob.filename)
  end

  direct :rails_blob_representation do |representation|
    route_for(:rails_service_blob_representation, representation.blob.signed_id, representation.variation_key, representation.blob.filename)
  end

  root to: "welcome#index"

  get "listing", to: "products#listing"
  
  get "me", to: "registrations#me"
  post "new", to: "registrations#create", as: :create_registration
  post "sign_in", to: "registrations#sign_in"
  post 'refresh', to: 'registrations#refresh'

  get "up", to: "rails/health#show", as: :rails_health_check
end
