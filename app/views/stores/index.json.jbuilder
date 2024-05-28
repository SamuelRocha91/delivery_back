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
    json.array! @stores do |product|
      json.extract! store, :id, :name, :description, :category, :address
      json.price number_to_currency(store.price)
      if store.avatar.attached?
       json.avatar_url rails_blob_url(store.avatar, only_path: true)
      end
    end
  end
end