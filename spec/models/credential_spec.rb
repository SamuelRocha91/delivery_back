require 'rails_helper'

RSpec.describe Credential, type: :model do

  describe "attribute presence check" do
    it { should have_db_column(:key) }
    it { should have_db_column(:access) }
    it { should_not have_db_column(:enum) }
    it { should define_enum_for(:access).with_values([:seller, :buyer])}
  end

  describe "checking field validations" do
    it "raises if the given access role is invalid" do
      expect {
        Credential.create_access(:non_existent)
      }.to raise_error "Invalid Access"
    end

    it "creates a credential for a given access role" do
      credential = Credential.create_access(:buyer)

      expect(credential).to be_buyer
      expect(credential.key).to_not be_empty
    end

    it { should allow_value("seller").for(:access) }
    it { should allow_value("buyer").for(:access) }    
  end

end
