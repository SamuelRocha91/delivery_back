require 'rails_helper'

RSpec.describe Credential, type: :model do
  describe ".create_access" do
    it "raises if the given access role is invalid" do
      expect {
        Credential.create_access(:non_existent)
      }.to raise_error "Invalid Access"
    end
  end
end
