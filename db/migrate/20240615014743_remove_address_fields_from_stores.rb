class RemoveAddressFieldsFromStores < ActiveRecord::Migration[7.1]
  def change
    remove_column :stores, :cep, :string
    remove_column :stores, :city, :string
    remove_column :stores, :state, :string
    remove_column :stores, :address, :text
    remove_column :stores, :neighborhood, :string
    remove_column :stores, :number_address, :string
  end
end
