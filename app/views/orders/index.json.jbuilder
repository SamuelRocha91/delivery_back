json.result do
  if params[:page].present?
     json.pagination do
       current = @orders.current_page
       total = @orders.total_pages
       per_page = @orders.limit_value
       json.current current
       json.per_page per_page
       json.pages total
       json.count @orders.total_count
       json.previous (current > 1 ? (current - 1) : nil)
       json.next (current == total ? nil : (current + 1))
     end
    end 
  json.orders do 
     json.array! @orders, :id, :state, :created_at
  end
end
