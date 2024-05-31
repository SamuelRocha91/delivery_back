class AddDescriptionToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :description, :text
  end
end
