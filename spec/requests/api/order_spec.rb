require "rails_helper"

require "rails_helper"

RSpec.describe "Orders API", type: :request do
    let!(:buyer) { create(:user) }
    let(:seller) {create(:user, :seller)}
    let!(:store) { create(:store, user: seller) }
    let!(:order) { create(:order, buyer: buyer, store: store) }
    let!(:order_items) { create_list(:order_item, 3, order: order) }
    let(:order_id) { order.id }

    describe "GET /orders" do
        before { get "/orders" }

        it "returns all orders" do
            expect(json).not_to be_empty
            expect(json.size).to eq(1)
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /orders/:id" do
        before { get "/orders/#{order_id}" }

        context "when the record exists" do
            it "returns the order" do
                expect(json).not_to be_empty
                expect(json["id"]).to eq(order_id)
            end

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end
        end

        context "when the record does not exist" do
            let(:order_id) { 100 }

            it "returns status code 404" do
                expect(response).to have_http_status(404)
            end

            it "returns a not found message" do
                expect(response.body).to match(/Couldn't find Order/)
            end
        end
    end

    describe "POST /orders" do
        let(:valid_attributes) { { buyer_id: buyer.id, store_id: store.id } }

        context "when the request is valid" do
            before { post "/orders", params: valid_attributes }

            it "creates an order" do
                expect(json["buyer_id"]).to eq(buyer.id)
                expect(json["store_id"]).to eq(store.id)
            end

            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end
        end

        context "when the request is invalid" do
            before { post "/orders", params: { buyer_id: buyer.id } }

            it "returns status code 422" do
                expect(response).to have_http_status(422)
            end

            it "returns a validation failure message" do
                expect(response.body).to match(/Validation failed: Store must exist/)
            end
        end
    end

    describe "PUT /orders/:id" do
        let(:valid_attributes) { { buyer_id: buyer.id } }

        context "when the record exists" do
            before { put "/orders/#{order_id}", params: valid_attributes }

            it "updates the order" do
                expect(response.body).to be_empty
            end

            it "returns status code 204" do
                expect(response).to have_http_status(204)
            end
        end

        context "when the record does not exist" do
            let(:order_id) { 100 }

            it "returns status code 404" do
                expect(response).to have_http_status(404)
            end

            it "returns a not found message" do
                expect(response.body).to match(/Couldn't find Order/)
            end
        end
    end

    describe "DELETE /orders/:id" do
        before { delete "/orders/#{order_id}" }

        it "returns status code 204" do
            expect(response).to have_http_status(204)
        end
    end
end