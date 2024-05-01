require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validations" do
    it "should be valid when name is filled" do
      store = Store.new name: "Greatest store ever!"
      expect(store.valid?).to eq true
    end
  end
end
