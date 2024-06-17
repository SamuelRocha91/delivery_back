json.extract! store, :id, :name, :description, :cnpj, :is_open, :category, :color_theme

if store.address.present?
  json.address do
    json.extract! store.address, :id, :street, :number, :neighborhood, :city, :state, :postal_code, :latitude, :longitude
  end
end

if store.avatar.attached?
  json.avatar_url rails_blob_url(store.avatar, only_path: true)
  json.thumbnail_url rails_representation_url(store.avatar.variant(resize_to_limit: [100, 100]), only_path: true)
end

json.url store_url(store, format: :json)
