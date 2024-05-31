json.result do
  if params[:page].present?
     json.pagination do
       current = @products.current_page
       total = @products.total_pages
       per_page = @products.limit_value
       json.current current
       json.per_page per_page
       json.pages total
       json.count @products.total_count
       json.previous (current > 1 ? (current - 1) : nil)
       json.next (current == total ? nil : (current + 1))
     end
   end
  json.products do 
    json.array! @products do |product|
      json.extract! product, :id, :title, :description
      json.category product.category_name
      json.price number_to_currency(product.price)
      if product.image.attached?
       json.image_url rails_blob_url(product.image, only_path: true)
      end
    end
  end
end