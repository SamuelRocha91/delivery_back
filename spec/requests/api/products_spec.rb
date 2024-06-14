require "rails_helper"

RSpec.describe "/stores/:store_id/products", type: :request do
   let(:user) { create(:user, :seller)}

   let(:credential) { Credential.create_access(:seller) }

   let(:signed_in) { api_sign_in(user, credential) }

   let(:store) {create(:store, user: user)}

   describe "GET /index" do
     it "renders a successful response with products data" do
       Product.create! title: "macarrao", price: 1.00, description: "Macarrao saboroso da vovo", category: "massas", store_id: store.id
       get "/stores/#{store.id}/products",
       headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
       json = JSON.parse(response.body)
       expect(json[0]["title"]).to eq "macarrao"
       expect(json[0]["price"].to_f).to eq 1.0
       expect(json[0]["category"]).to eq "massas"
     end

     it "returns a not found response if the product does not exist" do
       get "/stores/#{store.id}/products/999",
       headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
       expect(response.status).to eq 404
     end
   end

   describe "POST /products" do
     it "create products successfully" do
        post "/stores/#{store.id}/products",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
        params: {
          product: {
           title: "macarrao", price: 1, description: "Macarrao saboroso da vovo", category: "massas",
          }
        }
        json = JSON.parse(response.body)
        expect(json["id"]).to eq 1
        expect(json["title"]).to eq "macarrao"
        expect(response.status).to eq 201
     end

      it "adds error if product registration is incomplete" do
        post "/stores/#{store.id}/products",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
        params: {
          product: {
           title: "", price: "", description: "Macarrao", category: "",
          }
        }
        json = JSON.parse(response.body)
        expect(json["title"]).to eq ["can't be blank", "is too short (minimum is 3 characters)"]
        expect(json["price"]).to eq ["can't be blank", "is not a number"]
        expect(json["description"]).to eq ["is too short (minimum is 10 characters)"]
        expect(json["category"]).to eq ["can't be blank"]
        expect(response.status).to eq 422
     end
   end

   describe "PUT /products" do
     it "update products successfully" do
       product = Product.create title: "macarrao", price: 1, description: "Macarrao saboroso da vovo", category: "massas", store: store
        put "/stores/#{store.id}/products/#{product.id}",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
        params: {
          product: {
           price: 2.00 
          }
        }
        json = JSON.parse(response.body)
        expect(json["price"]).to eq "$2.00"
        expect(response.status).to eq 200
     end

    it "returns a not found response if the product does not exist" do
      put "/stores/#{store.id}/products/999",
      headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
      params: {
        product: {
          price: 2.00 
        }
      }
      expect(response.status).to eq 404
    end
   end

   describe "DELETE /products" do
     it "delete products successfully" do
       product = Product.create title: "macarrao", price: 1, description: "Macarrao saboroso da vovo", category: "massas", store: store
        delete "/stores/#{store.id}/products/#{product.id}",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
        expect(response.status).to eq 204
     end
   end
end