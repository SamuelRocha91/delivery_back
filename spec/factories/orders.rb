FactoryBot.define do
  factory :order do
    association :buyer, factory: :user
    association :store
    state { "created" }
    created_at { Time.current }
    updated_at { Time.current }

    trait :created do
      state { "created" }
    end

    trait :payment_pending do
      state { "payment_pending" }
    end

    trait :payment_confirmed do
      state { "payment_confirmed" }
    end

    trait :payment_failed do
      state { "payment_failed" }
    end

    trait :accepted do
      state { "accepted" }
    end

    trait :in_progress do
      state { "in_progress" }
    end

    trait :ready_for_delivery do
      state { "ready_for_delivery" }
    end

    trait :in_delivery do
      state { "in_delivery" }
    end

    trait :delivered do
      state { "delivered" }
    end

    trait :canceled do
      state { "canceled" }
    end
  end
end

