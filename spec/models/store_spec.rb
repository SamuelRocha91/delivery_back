require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    it "should be valid when name is filled" do
      store = Store.new name: "Greatest store ever!", user: create(:user)
      expect(store.valid?).to eq true
    end

    it "should validate presence of name" do
      store = Store.new
      expect(store).to_not be_valid
    end

    it "should validate presence of name" do
      should validate_presence_of :name
    end

    describe "belongs_to" do
      let(:admin) {
        User.create!(
          email: "admin@example.com",
          password: "123456",
          password_confirmation: "123456",
          role: :admin
        )
      }
      
      it "should not belong to admin users" do
        store = Store.create(name: "store", user: admin)
        expect(store.errors.full_messages).to eq ["User must exist"]
      end
    end
    
    it { should validate_length_of(:name).is_at_least(3) }
    it { should belong_to(:user) }
  end
end
