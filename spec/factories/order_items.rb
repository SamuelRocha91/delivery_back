# spec/factories/order_items.rb
FactoryBot.define do
  factory :order_item do
    association :order
    association :product
    amount { 1 }
    price { "9.99" }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
