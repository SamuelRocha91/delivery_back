require 'csv'

class AnalysisController < ApplicationController
  def anacor
    store_id = params[:store_id]

    sales_data = Analysis.anacor(store_id)
    products = sales_data.map { |row| row['product'] }.uniq
    Rails.logger.info "products: #{products}"

    days_of_week = (0..6).to_a.map { |d| Date::DAYNAMES[d.to_i] }
    Rails.logger.info "days_of_week: #{days_of_week}"

    contingency_table = Array.new(products.length) { Array.new(days_of_week.length, 0) }
    Rails.logger.info "contingency_table: #{contingency_table}"
    sales_data.each do |row|
      product_index = products.index(row['product'])
      day_index = row['day_of_week'].to_i
      contingency_table[product_index][day_index] = row['sales_count'].to_i
    end
    Rails.logger.info "sales_data: #{sales_data}"

    R.assign 'products', products
    R.assign 'days_of_week', days_of_week
    R.assign 'contingency_table', contingency_table.flatten
    Rails.logger.info "contingency_table: #{contingency_table}"

    graph_process

    coord_df = CSV.read('/tmp/coord_df.csv', headers: true)

    result = coord_df.map { |row| { product: row['Product'], coordinates: { Dim1: row['Dim1'], Dim2: row['Dim2'] } } }

    render json: { result: result, plot_image: '/tmp/anacor_plot.png' }
  end


   def monthly_analysis
    store_id = params[:store_id]

    sales_data = Analysis.monthly_analysis(store_id)
    @average_sales_per_day = sales_data.map { |row| [Date::DAYNAMES[row['day_of_week'].to_i], row['average_daily_sales']] }.to_h
    render json: { result: @average_sales_per_day}
  end

  private

  def graph_process
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
  end

end

