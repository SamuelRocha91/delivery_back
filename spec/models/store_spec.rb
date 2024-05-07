require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:admin) {
    create(:user_admin)
  }

  let(:store) { create(:store)}

  describe "attribute presence check" do
    it { should have_db_column(:name) }
    it { should have_db_column(:user_id) }
  end

  describe "checking relationships between tables" do
    it { should belong_to(:user) }
  end

  describe "checking field validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it "should not belong to admin users" do
      store = Store.create(name: "store", user: admin)
      expect(store.errors.full_messages).to eq ["User must exist"]
    end
    it "calls ensure_seller before validation" do
      store = Store.create(name: "Mc Donalds", user: admin)
      expect(store.user).to eq(nil)
    end
  end
end
