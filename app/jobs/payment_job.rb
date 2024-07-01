class PaymentJob < ApplicationJob
 queue_as :default
 
 def perform(order:, value:, number:, valid:, cvv:)
   order.pay!
   params = {payment: {value: value, number: number, valid: valid, cvv: cvv}}
   response = con.post("/payments", params.to_json)
   if response.success?
     order.confirm_payment!
   else
     order.payment_failed!
   end
  rescue Faraday::ConnectionFailed => e
    order.payment_failed!
    Rails.logger.error("Connection failed: #{e.message}")
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
