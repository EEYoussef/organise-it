FactoryBot.define do
  factory :payment do
    project { nil }
    payment_id { "MyString" }
    receipt_url { "MyString" }
    freelanceruser_id { nil }
    user_id { nil }
  end
end
