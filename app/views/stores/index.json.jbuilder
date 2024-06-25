json.result do
  if params[:page].present?
     json.pagination do
       current = @stores.current_page
       total = @stores.total_pages
       per_page = @stores.limit_value
       json.current current
       json.per_page per_page
       json.pages total
       json.count @stores.total_count
       json.previous (current > 1 ? (current - 1) : nil)
       json.next (current == total ? nil : (current + 1))
     end
   end
  json.stores do 
    json.array! @stores do |store|
      json.extract! store, :id, :name, :description, :cnpj, :is_open, :category, :color_theme
      json.distance store.address.distance_to(@current_address).round(2) if @current_address
      if store.avatar.attached?
       json.avatar_url rails_blob_url(store.avatar, only_path: true)
      end
    end
  end
end