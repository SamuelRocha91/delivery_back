json.extract! product, :id, :title, :created_at, :updated_at, :description, :store_id, :category, :product_available, :quantity_in_stock
json.price number_to_currency(product.price)
if product.image.attached?
  json.image_url rails_blob_url(product.image, only_path: true)
end
json.url store_products_url(product, format: :json)
