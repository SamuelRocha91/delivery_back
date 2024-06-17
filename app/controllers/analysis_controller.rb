require 'csv'

class AnalysisController < ApplicationController
  def anacor
    store_id = params[:store_id]
    thirty_days_ago = 30.days.ago

    sales_data = ActiveRecord::Base.connection.execute(
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

    products = sales_data.map { |row| row['product'] }.uniq
    days_of_week = (0..6).to_a.map { |d| Date::DAYNAMES[d.to_i] }

    contingency_table = Array.new(products.length) { Array.new(days_of_week.length, 0) }

    sales_data.each do |row|
      product_index = products.index(row['product'])
      day_index = row['day_of_week'].to_i
      contingency_table[product_index][day_index] = row['sales_count'].to_i
    end

    R.assign 'products', products
    R.assign 'days_of_week', days_of_week
    R.assign 'contingency_table', contingency_table.flatten

    R.eval <<-EOF
      library(FactoMineR)
      library(ggplot2)
      library(reshape2)  # Adicionando o pacote reshape2

      table_matrix <- matrix(contingency_table, nrow = length(products), byrow = TRUE)
      if (length(days_of_week) == ncol(table_matrix)) {
        colnames(table_matrix) <- days_of_week
      }
      if (length(products) == nrow(table_matrix)) {
        rownames(table_matrix) <- products
      }

      # Executando análise de correspondência
      anacor <- CA(table_matrix, graph = FALSE)
      coord <- anacor$row$coord

      # Preparando dados para o gráfico
      coord_df <- data.frame(Product = products, Dim1 = coord[,1], Dim2 = coord[,2])

      # Gerando o heatmap
      p <- ggplot(data = melt(table_matrix), aes(x = Var2, y = Var1, fill = value)) +
        geom_tile() +
        scale_fill_gradient(low = "yellow", high = "red") +
        labs(title = "Heatmap de Vendas por Produto e Dia da Semana",
             x = "Dia da Semana",
             y = "Produto",
             fill = "Vendas") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))

      ggsave('/tmp/anacor_plot.png', plot = p, width = 8, height = 6)

      # Salvando as coordenadas em um arquivo CSV
      write.csv(coord_df, '/tmp/coord_df.csv', row.names = FALSE)
    EOF

    coord_df = CSV.read('/tmp/coord_df.csv', headers: true)

    result = coord_df.map { |row| { product: row['Product'], coordinates: { Dim1: row['Dim1'], Dim2: row['Dim2'] } } }

    render json: { result: result, plot_image: '/tmp/anacor_plot.png' }
  end
end

