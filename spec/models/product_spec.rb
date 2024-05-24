require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "attribute presence check" do
    it { should have_db_column(:title) }
    it { should have_db_column(:price).of_type(:decimal).with_options(precision: 8, scale: 2) }
  end

  describe "checking relationships between tables" do
    it { should have_many(:orders).through(:order_items) }
    it { should belong_to(:store) }
  end

  describe "checking field validations" do
    it { should validate_length_of(:title).is_at_least(3) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end

