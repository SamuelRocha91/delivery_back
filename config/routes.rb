Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    passwords: 'passwords'
  }, skip: [:registrations]
  
  get "/stores/listing", to: "stores#listing"

  get 'sign_up', to: 'registrations#new', as: :sign_up_registration
  post 'sign_up' => 'registrations#create'
  get 'users' => 'registrations#index'
  resources :registrations, only: [:edit, :update]
  delete "deactivate_user/:id", to: "registrations#deactivate_user", as: :deactivate_user
  get "me", to: "registrations#me"
  post "new", to: "registrations#create", as: :create_registration
  post "sign_in", to: "registrations#sign_in"
  post 'refresh', to: 'registrations#refresh'

  resources :stores do
    get 'products', on: :member
    resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      collection do
        get 'listing', to: "products#listing_within_token"
      end
    end
    get "orders/new" => "stores#new_order"
    member do
      put 'reactivate_store', to: 'stores#reactivate', as: :reactivate_store
      put 'reactivate_product', to: 'products#reactivate', as: :reactivate_product
    end

    resources :orders, only: [:index, :show] do
      member do
        put 'accept'
        put 'start_progress'
        put 'ready_for_delivery'
        put 'start_delivery'
        put 'deliver'
        put 'cancel'
      end
    end
  end

  resources :credentials, only: [:index, :create, :update] 
    delete '/credentials/:id', to: 'credentials#destroy', as: 'delete_credential'
    
  scope :buyers do
    resources :orders, only: [:index, :create, :update, :destroy] do
      member do
        put 'pay'
      end
    end
    get 'orders/stream', to: 'orders#stream'  
    get 'orders/:id', to: 'orders#show', as: 'buyer_order'
  end

  get 'orders/create', to: 'orders#new'
  get "listing", to: "products#listing"
  get 'analysis/anacor', to: 'analysis#anacor'


  root to: "welcome#index"
  get "up", to: "rails/health#show", as: :rails_health_check

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount ActionCable.server => '/cable'

  direct :rails_blob do |blob|
    route_for(:rails_service_blob, blob.signed_id, blob.filename)
  end

  direct :rails_blob_representation do |representation|
    route_for(:rails_service_blob_representation, representation.blob.signed_id, representation.variation_key, representation.blob.filename)
  end

end
