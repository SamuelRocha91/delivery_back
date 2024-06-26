FactoryBot.define do
  factory :message do
    user { "MyString" }
    message { "MyText" }
    order_id { 1 }
  end
end
