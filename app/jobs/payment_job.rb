class PaymentJob

 def perform(order:, value:, number:, valid:, cvv:)
   params = {value: value, number: number, valid: valid, cvv: cvv}
   response = con.post("/payments", params.to_json)
   order.paid if response.success?
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