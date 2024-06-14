require 'rails_helper'

RSpec.describe PaymentJob, type: :job do
  let(:buyer) { create(:user, :buyer) }
  let(:seller) { create(:user, :seller) }
  let(:store) { create(:store, user: seller) }
  let(:order) { create(:order, store: store, buyer: buyer) }
  let(:valid_params) { { order: order, value: 30, number: 1234, valid: "12/25", cvv: 123 } }
  let(:payment_url) { Rails.configuration.payment.host }

  before do
    allow(Rails.configuration).to receive(:payment).and_return(OpenStruct.new(host: 'https://payment-gateway.example.com'))
  end

  describe '#perform' do
    context 'when the payment is successful' do
      before do
        allow_any_instance_of(Faraday::Connection).to receive(:post).and_return(double(success?: true))
        perform_enqueued_jobs { PaymentJob.perform_later(order: order, value: 30, number: 1234, valid: "12/25", cvv: 123) }
      end

      it 'transitions the order to payment_pending' do
        order.pay!
        expect(order.state).to eq('payment_pending')
      end

      it 'transitions the order to payment_confirmed' do
        PaymentJob.perform_now(order: order, value: 30, number: 1234, valid: "12/25", cvv: 123)
        order.reload
        expect(order.state).to eq('payment_confirmed')
      end
    end

    context 'when the payment fails' do
      before do
        allow_any_instance_of(Faraday::Connection).to receive(:post).and_return(double(success?: false))
        perform_enqueued_jobs { PaymentJob.perform_later(order: order, value: 30, number: 1234, valid: "12/25", cvv: 123) }
      end

      it 'transitions the order to payment_failed' do
        PaymentJob.perform_now(order: order, value: 30, number: 1234, valid: "12/25", cvv: 123)
        order.reload
        expect(order.state).to eq('payment_failed')
      end
    end

    context 'when an error occurs' do
      before do
        allow_any_instance_of(Faraday::Connection).to receive(:post).and_raise(StandardError.new("Connection error"))
      end

      it 'raises an error' do
        expect { PaymentJob.perform_now(order: order, value: 30, number: 1234, valid: "12/25", cvv: 123) }.to raise_error(StandardError, "Connection error")
      end
    end
  end
end

