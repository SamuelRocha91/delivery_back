FactoryBot.define do
  factory :order do
    association :buyer, factory: :user
    association :store
    state { "pending" }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
