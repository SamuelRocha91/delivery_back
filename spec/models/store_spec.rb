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

    it { should validate_length_of(:name).is_at_least(3) }
  end
end
