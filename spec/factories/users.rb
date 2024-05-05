FactoryBot.define do
  factory :user do
    email { "john@example.com" }
    password { "kosjksjd123235@" }
    password_confirmation { "kosjksjd123235@" }
    role {:seller}
  end
  
  factory :user_two, class: User do
    email { "johntwo@example.com" }
    password { "kosjksjd123235@" }
    password_confirmation { "kosjksjd123235@" }
    role {:seller}
  end

   factory :user_admin, class: User do
    email { "johntwo@example.com" }
    password { "kosjksjd123235@" }
    password_confirmation { "kosjksjd123235@" }
    role {:admin}
  end
end
