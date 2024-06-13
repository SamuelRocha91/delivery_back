FactoryBot.define do
  factory :product do
    title { Faker::Food.dish }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    description { Faker::Lorem.sentence(word_count: 10) }
    category { Product.categories.keys.sample }
    quantity_in_stock { Faker::Number.within(range: 1..100) }
    product_available { true }
    store

    trait :discarded do
      discarded_at { Time.current }
    end

    trait :with_image do
      after(:build) do |product|
        product.image.attach(io: File.open(Rails.root.join('spec', 'support', 'sample_image.jpg')), filename: 'sample_image.jpg', content_type: 'image/jpeg')
      end
    end

    trait :with_orders do
      after(:create) do |product|
        create_list(:order_item, 3, product: product)
      end
    end
  end
end

