require "rails_helper"

require "rails_helper"

RSpec.describe "Orders API", type: :request do
    let!(:buyer) { create(:user) }
    let(:seller) {create(:user, :seller)}
    let!(:store) { create(:store, user: seller) }
    let!(:order) { create(:order, store: store) }
    let!(:order_item) { create(:order_item, order: order, product: create(:product, store: store)) }
    let(:order_id) { order.id }
    let(:credential) { Credential.create_access(:buyer) }
    let(:signed_in) { api_sign_in(buyer, credential) }
    let(:headers) { { "Accept" => "application/json", "Authorization" => "Bearer #{signed_in['token']}", "X-API-KEY" => credential.key } }

    describe "GET /buyers/orders" do
      before { get "/buyers/orders", headers: headers }

        it "returns all orders" do
            json = JSON.parse(response.body)
            expect(json).not_to be_empty
            expect(json.size).to eq(1)
        end

        it "returns status code 200" do
            puts response.inspect
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /buyers/orders/:id" do
      before { get "/buyers/orders/#{order_id}", headers: headers}
      context "when the record exists" do
        it "returns the order" do
          json = JSON.parse(response.body)
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
      let(:valid_attributes) { { order: { store_id: store.id, order_items_attributes: [product_id: 1, amount: 3, price: 10] }} }
      context "when the request is valid" do
        before { post "/buyers/orders", headers: headers, params: valid_attributes }
          it "creates an order" do
            json = JSON(response.body)
            expect(json["order"]["store_id"]).to eq(store.id)
          end

          it "returns status code 201" do
            expect(response).to have_http_status(201)
          end
        end

        context "when the request is invalid" do
          before { post "/buyers/orders", headers: headers, params: { buyer_id: buyer.id } }

          it "returns status code 422" do
            expect(response).to have_http_status(400)
          end
        end
    end
end