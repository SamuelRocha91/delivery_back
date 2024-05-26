json.result do
  json.products do 
    json.array! @products do |product|
      json.extract! product, :id, :title, :description, :category
      json.price number_to_currency(product.price)
      if product.image.attached?
       json.image_url rails_blob_url(product.image, only_path: true)
      end
    end
  end
end