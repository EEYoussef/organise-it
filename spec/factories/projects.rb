FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyString" }
    budget { "MyString" }
    price { 1 }
    user { nil }
  end
end
