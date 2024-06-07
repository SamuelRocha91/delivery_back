class PaymentJob < ApplicationJob
 queue_as :default
 
 def perform(order:, value:, number:, valid:, cvv:)
   params = {payment: {value: value, number: number, valid: valid, cvv: cvv}}
   response = con.post("/payments", params.to_json)
   if response.success?
     order.confirm_payment 
      OrdersChannel.notify_user(order.buyer, order, "Payment confirmed")
      OrdersChannel.notify_user(order.store, order, "Payment confirmed")
   else
      order.payment_failed
      OrdersChannel.notify_user(order.buyer, order, "Payment failed")
   end
 end

 private

 def config
   Rails.configuration.payment
 end
 
 def con
   @con ||= Faraday.new(
     url: config.host,
     headers: {
       "Content-Type" => "application/json",
       "Accept" => "application/json",
      }
     )
 end
end