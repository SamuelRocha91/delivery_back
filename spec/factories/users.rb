# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { :buyer } # default role

    trait :admin do
      role { :admin }
    end

    trait :seller do
      role { :seller }
    end

    trait :developer do
      role { :developer }
    end

    after(:build) do |user|
      user.stores << build(:store, user: user) if user.seller?
    end
  end
end

