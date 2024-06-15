class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
