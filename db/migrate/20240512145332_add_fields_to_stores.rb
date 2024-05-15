class AddFieldsToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :price_minimum, :string
    add_column :stores, :phone_number, :string
    add_column :stores, :description, :text
    add_column :stores, :category, :string
    add_column :stores, :address, :text
  end
end
