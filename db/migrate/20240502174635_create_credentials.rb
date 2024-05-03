class CreateCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :credentials do |t|
      t.integer :access
      t.string :key, null: false

      t.timestamps
    end
  end
end
