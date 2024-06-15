FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    user
    cnpj { Faker::Company.brazilian_company_number }
    description { Faker::Lorem.paragraph }
    is_open { [true, false].sample } 
    color_theme { Faker::Color.hex_color }
    
    trait :with_products do
      transient do
        products_count { 3 } 
      end
      
      after(:create) do |store, evaluator|
        create_list(:product, evaluator.products_count, store: store)
      end
    end
    
    trait :closed do
      is_open { false }
    end
    
    trait :discarded do
      discarded_at { Time.now }
    end
  end
end
