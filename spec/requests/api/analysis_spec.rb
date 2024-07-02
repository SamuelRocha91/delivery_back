require "rails_helper"

RSpec.describe "Analysis API", type: :request do
    let(:user) { create(:user, :seller) }
    let(:credential) { Credential.create_access(:seller) }
    let(:signed_in) { api_sign_in(user, credential) }
    let(:store) { create(:store, user: user) }
    let(:product) { create(:product, store: store) }
    let!(:order) { create(:order, store: store) }
    let!(:order_item) { create(:order_item, order: order, product: create(:product, store: store)) }
    let(:payment) { create(:payment, order: order) }


    describe "get analysis/monthly_analysis" do
        it "returns a successful response with monthly analysis" do
            get "/analysis/monthly_analysis?store_id=#{store.id}",
            headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
            json = JSON.parse(response.body)
            expect(json).to include("result")
            expect(response).to have_http_status(:success)
            expect(json["result"]).to be_a(Hash)
        end
        it "returns a not found response if the store does not exist" do
            get "/analysis/monthly_analysis?store_id=999",
            headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
            json = JSON.parse(response.body)
            expect(json).to include("error")
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "get analysis/total_orders" do
        it "returns a successful response with total orders" do
            get "/analysis/total_orders?store_id=#{store.id}",
            headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
            json = JSON.parse(response.body)
            expect(json).to include("result")
            expect(response).to have_http_status(:success)
            expect(json["result"]).to be_a(Integer)
        end
        it "returns a not found response if the store does not exist" do
            get "/analysis/total_orders?store_id=999",
            headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
            json = JSON.parse(response.body)
            expect(json).to include("error")
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "get analysis/total_sales" do
        it "returns a successful response with total sales" do
            get "/analysis/total_sales?store_id=#{store.id}",
            headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
            json = JSON.parse(response.body)
            expect(json).to include("result")
            expect(response).to have_http_status(:success)
            expect(json["result"]).to be_a(Float)
        end
        it "returns a not found response if the store does not exist" do
            get "/analysis/total_sales?store_id=999",
            headers: {"Accept" => "application/json", "Authorization" => "Bearer #{signed_in["token"]}"}
            json = JSON.parse(response.body)
            expect(json).to include("error")
            expect(response).to have_http_status(:not_found)  
        end
    end

    

end