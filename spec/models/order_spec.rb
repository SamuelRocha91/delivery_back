require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "attribute presence check" do
    it { should have_db_column(:state) }
    it { should have_db_column(:buyer_id)}
    it { should have_db_column(:store_id)}
  end

  describe "checking relationships between tables" do
    it { should have_many(:products).through(:order_items) }
  end

  describe "checking field validations" do
    it "save the order succesfull" do
      user = create(:user_buyer)
      store = create(:store)
      order = Order.create(buyer: user, store: store)
      expect(order.buyer_id).to eq 1
    end
    it "adds an error to the order" do
      user_three = create(:user_three)
      store_two = create(:store)
      order = Order.create(buyer: user_three, store: store_two)
      expect(order.errors[:buyer]).to include("should be a `user.buyer`")
    end

    it "transitions from created to accepted" do
      user_three = create(:user_buyer)
      store_two = create(:store)
      order = Order.create(buyer: user_three, store:  store_two)
      expect(order.state).to eq("created")
      order.accept!
      expect(order.state).to eq("accepted")
    end
  end

end
