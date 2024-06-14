require "rails_helper"

RSpec.describe "registrations", type: :request do
  let(:user) { create(:user, :buyer)}
  let(:credential) { Credential.create_access(:buyer) }
  let(:credential_seller) { Credential.create_access(:seller) }
  let(:signed_in) { api_sign_in(user, credential) }

  describe "get /me" do    
    it "returns hash with user data" do
      get(
        "/me",
        headers: {
          "Accept" => "application/json",
           "X-API-KEY" => credential.key,
           "Authorization" => "Bearer #{signed_in["token"]}"
        },
      )
      json = JSON.parse(response.body)
      expect(json["email"]).to match (/@/)
    end
  end

  describe "POST /new" do
    it "creates a buyer user" do
      post(
        "/new",
        headers: {"Accept" => "application/json", "X-API-KEY" => credential.key},
        params: {
          user: {
            email: "admin_user@example.com",
            password: "123456",
            password_confirmation: "123456",
          }
        }
      )
      user = User.find_by(email: "admin_user@example.com")
      expect(response).to be_successful
      expect(user).to be_buyer
    end

    it "fail to create user without credentials" do
      post(
        "/new",
        headers: {"Accept" => "application/json"},
        params: {
          user: {
            email: "admin_user@example.com",
            password: "123456",
            password_confirmation: "123456"
          }
        }
      )
      expect(response).to be_unprocessable
    end

    it "creates a seller user" do
      post(
        "/new",
        headers: {"Accept" => "application/json", "X-API-KEY" => credential_seller.key},
        params: {
          user: {
            email: "samtuo@hotmail.com",
            password: "123456",
            password_confirmation: "123456"
          }
        }
      )
      user = User.find_by(email: "samtuo@hotmail.com")
      expect(response).to be_successful
      expect(user).to be_seller
    end
  end

  describe "post /sign_in" do
    before do
      User.create!(
        email: "seller@example.com",
        password: "123456",
        password_confirmation: "123456",
        role: :seller
      )
    end
    
    it "prevents users with roles different from credentials do sign in" do
      post(
        "/sign_in",
        headers: {
          "Accept" => "application/json",
          "X-API-KEY" => credential.key
        },
        params: {
          login: {email: "seller@example.com", password: "123456"}
        }
      )
      expect(response).to be_unauthorized
    end
  end

  describe "post /sign_in" do
    before do
      User.create!(
        email: "seller@example.com",
        password: "123456",
        password_confirmation: "123456",
        role: :seller
      )
    end
    
    it "prevents users with roles different from credentials do sign in" do
      post(
        "/sign_in",
        headers: {
          "Accept" => "application/json",
           "X-API-KEY" => credential.key
        },
        params: {
          login: {email: "seller@example.com", password: "123456"}
        }
      )
      expect(response).to be_unauthorized
    end
  end

  describe "post /refresh", :slow do
    let(:refresh_token) { create(:refresh_token, user: user) }

    it "refresh token with success" do
      post(
        "/refresh",
        headers: {
          "Accept" => "application/json",
          "X-API-KEY" => credential.key
        },
        params: {
          refresh_token: refresh_token.refresh_token
        }
      )
      expect(response).to be_successful
      expect(JSON.parse(response.body)["email"]).to eq(user.email)
      expect(JSON.parse(response.body)["token"]).to be_present
    end

    it "fail to refresh token with invalid token" do
      post(
        "/refresh",
        headers: {
          "Accept" => "application/json",
          "X-API-KEY" => credential.key
        },
        params: {
          refresh_token: "invalid"
        }
      )
      expect(response).to be_unauthorized
    end
  end
  
  describe

  describe "Delete /deactivate_user" do
    let(:user) { create(:user, :buyer)}

    it "deactivate user with success" do
      delete(
        deactivate_user_path(user.id),
        headers: {
          "Accept" => "application/json",
          "X-API-KEY" => credential.key,
          "Authorization" => "Bearer #{signed_in["token"]}"
        },
      )
      expect(response).to be_successful
    end
  end
end