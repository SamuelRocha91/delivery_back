FactoryBot.define do
  factory :store do
    name { "MyString" }
    association :user
  end

  factory :store_two, class: Store do
    name { "New Store" }
    association :user
  end
end
