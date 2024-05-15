json.extract! store, :id, :name, :created_at, :updated_at, :price_minimum, :description, :phone_number, :category, :address
if store.avatar.attached?
  json.avatar_url rails_blob_url(store.avatar, only_path: true)
end
json.url store_url(store, format: :json)
