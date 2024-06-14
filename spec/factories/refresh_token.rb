FactoryBot.define do
    factory :refresh_token do
      refresh_token { SecureRandom.hex(64) }
      user
      expires_at { 1.day.from_now }
    end
end