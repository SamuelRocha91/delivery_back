FactoryBot.define do
  factory :product do
    association :store 
    title { "MyString" }
    price { 20.99 }
  end
end
