require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:admin) { create(:user, :admin) }
  let(:seller) { create(:user, :seller) }

  let(:store) { create(:store, user: seller) }

  describe "attribute presence check" do
    it { should have_db_column(:name) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:cep) }
    it { should have_db_column(:city) }
    it { should have_db_column(:state) }
    it { should have_db_column(:category) }
    it { should have_db_column(:cnpj) }
    it { should have_db_column(:address) }
    it { should have_db_column(:neighborhood) }
    it { should have_db_column(:number_address) }
    it { should have_db_column(:description) }
    it { should have_db_column(:is_open) }
    it { should have_db_column(:color_theme) }
  end

  describe "checking relationships between tables" do
    it { should belong_to(:user) }
    it { should have_many(:products).dependent(:destroy) }
    it { should have_one_attached(:avatar) }
  end

  describe "checking field validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should define_enum_for(:category).with_values([:bar, :depósito, :lanchonete, :loja, :mercado, :restaurante]) }
    it "should not belong to admin users" do
      store = Store.create(name: "store", user: admin)
      expect(store.errors.full_messages).to eq ["User must exist"]
    end
    it "calls ensure_seller before validation" do
      store = Store.create(name: "Mc Donalds", user: admin)
      expect(store.user).to eq(nil)
    end
    it "checks that the store is disposed of correctly" do
      store.discard!
      expect(store.discarded?).to eq true
    end
  end

end
