class AddFieldsToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :cep, :string
    add_column :stores, :city, :string
    add_column :stores, :state, :string
    add_column :stores, :category, :string
    add_column :stores, :cnpj, :string
    add_column :stores, :address, :text
    add_column :stores, :neighborhood, :string
    add_column :stores, :number_address, :decimal
  end
end
