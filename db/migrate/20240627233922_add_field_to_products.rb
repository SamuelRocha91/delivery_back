class AddFieldToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :is_inventory_product, :boolean
  end
end
