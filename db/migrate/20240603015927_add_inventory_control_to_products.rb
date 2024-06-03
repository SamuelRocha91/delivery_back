class AddInventoryControlToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :quantity_in_stock, :integer
    add_column :products, :product_available, :boolean
  end
end
