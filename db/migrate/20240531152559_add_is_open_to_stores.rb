class AddIsOpenToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :is_open, :boolean
  end
end
