class CreateCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :credentials do |t|
      t.integer :access
      t.string :key

      t.timestamps
    end
  end
end
