class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :store, null: false, foreign_key: true
      t.string :title
      t.string :price

      t.timestamps
    end
  end
end
