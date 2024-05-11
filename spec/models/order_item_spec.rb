require 'rails_helper'

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "attribute presence check" do

    it { should have_db_column(:amount).with_options(default: 1) }
    it { should have_db_column(:price).of_type(:decimal) }
  end

   
  describe "checking field validations" do
    it "creates a new order_item successfully" do
      user = create(:user_buyer)
      store = create(:store)
      product = Product.create(store: store, title: "Mc DOnalds", price: 1.50)
      order = Order.create(buyer: user, store: store)
      order_item = OrderItem.create(order: order, product: product, price: 1.00, amount: 2 )
      expect(order_item).to be_valid
      expect(order_item.price).to eq 1.00
      expect(order_item.amount).to eq 2 
    end

    it "adds an error to the order" do
      user = create(:user_buyer)
      store = create(:store)
      store_two = Store.create(name: "Japan", user: create(:user_two))
      product = Product.create(store: store_two, title: "Mc DOnalds", price: 1.50)
      order = Order.create(buyer: user, store: store)
      order_item = OrderItem.create(order: order, product: product, amount: 2, price: 4)
      expect(order_item.errors[:product]).to include( "product should belong to `Store`: #{order.store.name}")
    end
  end
end
