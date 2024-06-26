class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :user
      t.text :message
      t.integer :order_id

      t.timestamps
    end
  end
end
