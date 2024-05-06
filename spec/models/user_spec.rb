require 'rails_helper'

RSpec.describe User, type: :model do
    describe "presence and validation of columns" do
      it "checks if the table contains the correct attributes" do
        user = User.create(email: "macarrao@hotmail.com", password: '123456', password_confirmation: '123456', role: :admin)
        expect(user).to be_valid
        expect(user.email).to eq "macarrao@hotmail.com"
        expect(user.role).to eq "admin"
    end

    it "check if the user is invalid when the role atributte is missing" do
        user = User.create(email: "macarrao@hotmail.com", password: '123456', password_confirmation: '123456')
        expect(user).not_to be_valid
        expect(user.errors[:role]).to include "can't be blank" 
    end

     it "checks if passwords match" do
        user = User.create(email: "macarrao@hotmail.com", password: '123456', password_confirmation: '123457', role: :admin)
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to include "doesn't match Password" 
     end

      it "checks if email is valid" do
        user = User.create(email: "@hotmail.com", password: '123456', password_confirmation: '123457', role: :admin)
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include "is invalid" 
     end

     it "checks if role is valid" do
      expect {
        User.create(email: "example@hotmail.com", password: '123456', password_confirmation: '123457', role: :elefante)
      }.to raise_error(ArgumentError, "'elefante' is not a valid role")
    end
  end
end
