class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :user
      t.text :message
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
