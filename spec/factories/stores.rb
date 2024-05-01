FactoryBot.define do
  factory :store do
    name { "MyString" }
    association :user
  end
end
