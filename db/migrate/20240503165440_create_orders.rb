class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :buyer, foreign_key: { to_table: :users }, null: false
      t.references :store, foreign_key: true, null: false
      t.timestamps
    end
  end
end
