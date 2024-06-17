class Analysis < ApplicationRecord
  def self.anacor(store_id)
    thirty_days_ago = 30.days.ago   
    ActiveRecord::Base.connection.execute(
    ActiveRecord::Base.sanitize_sql_array(["
      SELECT 
      p.title AS product,
      strftime('%w', o.created_at) AS day_of_week,
      COUNT(*) AS sales_count
      FROM 
      orders o
      JOIN 
      order_items oi ON o.id = oi.order_id
      JOIN 
      products p ON oi.product_id = p.id
      WHERE 
      o.store_id = ? AND o.created_at >= ?
      GROUP BY 
      p.title, day_of_week
      ORDER BY 
      p.title, day_of_week;", store_id, thirty_days_ago])
    )
  end
  def self.monthly_analysis(store_id)
    one_months_ago = 1.month.ago
    ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.sanitize_sql_array(["
        SELECT 
          strftime('%w', o.created_at) AS day_of_week,
          AVG(oi.amount * oi.price) AS average_daily_sales
        FROM 
          orders o
        JOIN 
          order_items oi ON o.id = oi.order_id
        WHERE 
          o.store_id = ? AND o.created_at >= ?
        GROUP BY 
          day_of_week
        ORDER BY 
          day_of_week;", store_id, one_months_ago])
    )
  end
end