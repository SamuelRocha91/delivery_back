json.extract! store, :id, :name, :description, :category, :address, :cep, :state, :city, :neighborhood, :number_address, :cnpj
if store.avatar.attached?
  json.avatar_url rails_blob_url(store.avatar, only_path: true)
end
json.url store_url(store, format: :json)
