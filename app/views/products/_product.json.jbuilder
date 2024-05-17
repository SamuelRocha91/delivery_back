json.extract! product, :id, :title, :created_at, :updated_at, :price, :description, :category
if product.image.attached?
  json.image_url rails_blob_url(product.image, only_path: true)
end
json.url store_products_url(product, format: :json)
