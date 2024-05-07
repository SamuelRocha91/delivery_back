FactoryBot.define do
  factory :order do
    association :buyer, factory: :user_buyer
    association :store
  end
end
