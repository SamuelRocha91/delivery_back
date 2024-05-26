json.result do
  json.products do 
    json.array! @products do |product|
      json.extract! product, :id, :title
      json.price number_to_currency(product.price)
    end
  end
end