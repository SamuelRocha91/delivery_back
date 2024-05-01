class AddUserIdToStores < ActiveRecord::Migration[7.1]
  def change
    add_reference :stores, :user, foreign_key: true
  end
end
