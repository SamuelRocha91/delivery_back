class AddDiscardedAtToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :discarded_at, :datetime
    add_index :stores, :discarded_at
  end
end
