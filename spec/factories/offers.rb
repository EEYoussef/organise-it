FactoryBot.define do
  factory :offer do
    message { "MyText" }
    user { nil }
    project { nil }
    accept { false }
  end
end
