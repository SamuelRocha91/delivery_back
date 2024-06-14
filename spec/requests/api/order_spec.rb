require "rails_helper"

RSpec.describe "Orders API", type: :request do
    let!(:buyer) { create(:user) }
    let(:seller) {create(:user, :seller)}
    let!(:store) { create(:store, user: seller) }
    let!(:order) { create(:order, store: store) }
    let!(:order_item) { create(:order_item, order: order, product: create(:product, store: store)) }
    let(:order_id) { order.id }
    let(:credential) { Credential.create_access(:buyer) }
    let(:credential_seller) { Credential.create_access(:seller) }
    let(:signed_in) { api_sign_in(buyer, credential) }
    let(:headers) { { "Accept" => "application/json", "Authorization" => "Bearer #{signed_in['token']}", "X-API-KEY" => credential.key } }
    let(:valid_attributes) { { payment: { value: 30, number: 1234, valid: "12/25", cvv: 123 } } }
    let (:headers_seller) { { "Accept" => "application/json", "Authorization" => "Bearer #{api_sign_in(seller, credential_seller)['token']}", "X-API-KEY" => credential_seller.key } }

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

    describe "PUT /buyers/orders/:id/pay" do
      context "when the record exists" do

        before { put "/buyers/orders/#{order.id}/pay", headers: headers, params: valid_attributes }
          it "returns status code 200" do
            expect(response).to have_http_status(200)
          end

          it "returns a payment processing message" do
            json = JSON.parse(response.body)
            expect(json['message']).to eq('Payment processing started')
          end

          it "enqueues a PaymentJob" do
            allow(PaymentJob).to receive(:perform_later)
            assert_enqueued_jobs 1
          end
      end
    end

    describe "PUT /stores/:store_id/orders/:id/accept" do
      context "when the record exists" do
        before { 
          order.pay!
          order.reload
          order.confirm_payment!
          order.reload
        }
        before { put "/stores/#{store.id}/orders/#{order.id}/accept", headers: headers }

        it "returns status code 200" do
          expect(response).to have_http_status(200)
        end

        it "returns a success message" do
          json = JSON.parse(response.body)
          expect(json['message']).to eq('Pedido aceito com sucesso')
        end

        it "changes the order state to accepted"do
          order.reload
          expect(order.state).to eq('accepted')
        end

        it "returns the order" do
          json = JSON.parse(response.body)
          expect(json['order']['state']).to eq('accepted')
        end

      context "when the record does not exist" do
        before { put "/stores/#{store.id}/orders/100/accept", headers: headers }

        it "returns status code 404"  do
          expect(response).to have_http_status(404)
        end

        it "returns a not found message" do
          expect(response.body).to match(/Couldn't find Order/)
        end
      end
    end

    describe "PUT /stores/:store_id/orders/:id/cancel" do
      context "when the record exists" do
        before { put "/stores/#{store.id}/orders/#{order.id}/cancel", headers: headers }

        it "returns status code 200" do
          expect(response).to have_http_status(200)
        end

        it "returns a success message" do
          json = JSON.parse(response.body)
          expect(json['message']).to eq('Pedido cancelado')
        end

        it "changes the order state to canceled" do
          order.reload
          expect(order.state).to eq('canceled')
        end

        it "returns the order" do
          json = JSON.parse(response.body)
          expect(json['order']['state']).to eq('canceled')
        end
      end
        
      context "when the record does not exist" do
        before { put "/stores/#{store.id}/orders/100/cancel", headers: headers }
  
        it "returns status code 404" do
          expect(response).to have_http_status(404)
        end
  
        it "returns a not found message" do
          expect(response.body).to match(/Couldn't find Order/)
        end
      end
    end
  end
end