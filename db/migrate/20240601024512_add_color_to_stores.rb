class AddColorToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :color_theme, :string
  end
end
