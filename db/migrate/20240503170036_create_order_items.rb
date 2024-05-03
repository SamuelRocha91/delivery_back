class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
      t.integer :amount, default: 1, null: false
      t.decimal "price", precision: 8, scale: 2, null: false
      t.timestamps
    end
  end
end
