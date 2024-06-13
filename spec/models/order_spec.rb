require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "attribute presence check" do
    it { should have_db_column(:state) }        
    it { should have_db_column(:buyer_id) }
    it { should have_db_column(:store_id) }
    it { should belong_to(:buyer) }
    it { should belong_to(:store) }
    it { should have_many(:order_items) }
    it { should have_many(:products).through(:order_items) }
  end

  describe "checking field validations" do
    it "save the order successfully" do
      user = create(:user, :buyer)
      seller = create(:user, :seller)
      store = create(:store, user: seller)
      order = Order.create(buyer: user, store: store)
      expect(order.buyer_id).to eq(user.id)
    end

    it "adds an error to the order if buyer is not a user.buyer" do
      user_three = create(:user, :seller)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.errors[:buyer]).to include("should be a `user.buyer`")
    end

    it "transitions from created to payment_pending" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.state).to eq("created")
      order.pay!
      expect(order.state).to eq("payment_pending")
    end

    it "transitions from payment_pending to payment_confirmed" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      expect(order.state).to eq("payment_pending")
      order.confirm_payment!
      expect(order.state).to eq("payment_confirmed")
    end

    it "transitions from payment_pending to payment_failed" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      expect(order.state).to eq("payment_pending")
      order.payment_failed!
      expect(order.state).to eq("payment_failed")
    end

    it "transitions from payment_confirmed to accepted" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      order.confirm_payment!
      expect(order.state).to eq("payment_confirmed")
      order.confirm!
      expect(order.state).to eq("accepted")
    end

    it "transitions from created to canceled" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.state).to eq("created")
      order.cancel!
      expect(order.state).to eq("canceled")
    end

    it 'transitions from accepted to in_progress' do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      order.confirm_payment!
      order.confirm!
      expect(order.state).to eq("accepted")
      order.start_progress!
      expect(order.state).to eq("in_progress")
    end

    it 'transitions from in_progress to ready_for_delivery' do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      order.confirm_payment!
      order.confirm!
      order.start_progress!
      expect(order.state).to eq("in_progress")
      order.ready_for_delivery!
      expect(order.state).to eq("ready_for_delivery")
    end

    it 'transitions from ready_for_delivery to in_delivery' do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      order.confirm_payment!
      order.confirm!
      order.start_progress!
      order.ready_for_delivery!
      expect(order.state).to eq("ready_for_delivery")
      order.start_delivery!
      expect(order.state).to eq("in_delivery")
    end

    it 'transitions from in_delivery to delivered' do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      order.pay!
      order.confirm_payment!
      order.confirm!
      order.start_progress!
      order.ready_for_delivery!
      order.start_delivery!
      expect(order.state).to eq("in_delivery")
      order.deliver!
      expect(order.state).to eq("delivered")
    end

    it "returns the states of the order" do
      expect(Order.states).to eq([:created, :payment_pending, :payment_confirmed, :payment_failed, :accepted, :in_progress, :ready_for_delivery, :in_delivery, :canceled, :delivered])
    end

    it "accepts nested attributes for order_items" do
      should accept_nested_attributes_for(:order_items)
    end

    it "returns the global id of the order" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.to_global_id).to eq(order.to_global_id)
    end

    it "returns the buyer id of the order" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.buyer_id).to eq(user_three.id)
    end

    it "returns the store id of the order" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.store_id).to eq(store_two.id)
    end

    it "returns the buyer of the order" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.buyer).to eq(user_three)
    end

    it "returns the store of the order" do
      user_three = create(:user, :buyer)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.store).to eq(store_two)
    end

    it "returns the order successfully" do
      user = create(:user, :buyer)
      seller = create(:user, :seller)
      store = create(:store, user: seller)
      order = Order.create(buyer: user, store: store)
      expect(order.buyer_id).to eq(user.id)
    end

    it "adds an error to the order if buyer is not a user.buyer" do
      user_three = create(:user, :seller)
      seller = create(:user, :seller)
      store_two = create(:store, user: seller)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.errors[:buyer]).to include("should be a `user.buyer`")
    end

  end
end