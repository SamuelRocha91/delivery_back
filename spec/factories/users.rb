FactoryBot.define do
  factory :user do
    email { "john@example.com" }
    password { "kosjksjd123235@" }
    password_confirmation { "kosjksjd123235@" }
  end
  
  factory :user_two, class: User do
    email { "johntwo@example.com" }
    password { "kosjksjd123235@" }
    password_confirmation { "kosjksjd123235@" }
  end
end
