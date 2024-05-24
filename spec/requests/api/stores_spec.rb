require "rails_helper"

RSpec.describe "/stores", type: :request do
  let(:user) { create(:user)}

  let(:credential) { Credential.create_access(:seller) }

  let(:signed_in) { api_sign_in(user, credential) }

  let(:store) { Store.create name: "New Store", user: user}

  describe "GET /show" do
    it "renders a successful response with stores data" do
      get "/stores/#{store.id}", headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
      json = JSON.parse(response.body)

      expect(json["name"]).to eq "New Store"
    end

     it "renders a failure response when accessing an invalid store" do
      get "/stores/2", headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}

      expect(response).to have_http_status(:not_found)
    end
  end

   describe "GET /index" do
    
    it "renders a successful response with stores data" do
      store = Store.create name: "New Store", user: user
      get "/stores", headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response).to be_an(Array)
      expect(json_response.length).to eq(1)

      expect(json_response[0]["id"]).to eq(store.id)
      expect(json_response[0]["name"]).to eq(store.name)
    end
  end

  describe "POST /products" do
    it "create stores successfully" do
      post "/stores",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
        params: {
          store: {
           name: "Lojas mercadinho",
          }
        }
      json = JSON.parse(response.body)
      expect(json["id"]).to eq 1
      expect(json["name"]).to eq "Lojas mercadinho"
      expect(response.status).to eq 201
     end


    it "adds error if store registration is incomplete" do
      post "/stores",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
        params: {
          store: {
           name: ""
          }
        }
      json = JSON.parse(response.body)
      expect(json["name"]).to eq ["can't be blank", "is too short (minimum is 3 characters)"]
      expect(response.status).to eq 422
     end
  end


   describe "PUT /stores" do
     it "update stores successfully" do
        put "/stores/#{store.id}",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"},
        params: {
          store: {
           name: "gmail" 
          }
        }
        json = JSON.parse(response.body)
        expect(json["name"]).to eq "gmail"
        expect(response.status).to eq 200
     end
   end


   describe "DELETE /stores" do
     it "delete stores successfully" do
        delete "/stores/#{store.id}",
        headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
        expect(response.status).to eq 204
        expect(store.reload.discarded_at).not_to be_nil
     end
   end

end