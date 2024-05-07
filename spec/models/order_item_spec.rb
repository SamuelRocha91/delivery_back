require 'rails_helper'

RSpec.describe OrderItem, type: :model do
    let(:user) {create(:user)}
    let(:store) {Store.create(name: "Burguer King", user: user)}
    let(:product) { Product.create(store: store, title: "Macarrão", price: 2.00)}
    let(:buyer) { create(:user_buyer) }
    let(:order) { Order.create(buyer: buyer, store: store) }

  describe "checking field validations" do
  
    it "creates a new order_item successfully" do
      order_item = OrderItem.create(order: order, product: product, price: 1.00, amount: 2 )
      expect(order_item).to be_valid
      expect(order_item.price).to eq 1.00
      expect(order_item.amount).to eq 2 
    end

    it "adds an error to the order" do
      store_two = Store.create(name: "Mac Donalds", user: user)
      product_two =  Product.create(store: store_two, title: "Macarrão", price: 2.00)
      order_item = OrderItem.create(order: order, product: product_two, price: 1.00, amount: 2)
      expect(order_item.errors[:product]).to include("product should belong to `Store`: #{order.store.name}")
    end

  end
end
