class AddStateToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :state, :string
  end
end
