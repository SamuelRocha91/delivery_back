require 'rails_helper'

RSpec.describe User, type: :model do

  describe "attribute presence check" do
    it { should have_db_column(:email) }
    it { should have_db_column(:role) }
    it { should define_enum_for(:role) }
    it { should_not define_enum_for(:elefante) }
  end

  describe "checking relationships between tables" do
    it { should have_many(:stores) }
  end

  describe "checking field validations" do
    it { should validate_presence_of(:role) }
    it { should define_enum_for(:role).with_values([:admin, :seller, :buyer, :developer]) }
    it { should_not allow_value('sam').for(:email) }
    it { should allow_value('sam@hotmail.com').for(:email) }

    it "is expected to validate that :role should raise an exception in case of invalid role" do
      expect {
      User.new(role: 'elefante')
      }.to raise_error(ArgumentError, "'elefante' is not a valid role")
    end


    it "is expected to validate that :password_confirmation cannot be different of password" do
      user = User.create(email: "elefante@hotmail.com", password: '123456', password_confirmation: '123457', role: :admin)
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include "doesn't match Password" 
    end

  end
end
