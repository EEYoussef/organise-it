FactoryBot.define do
  factory :project_outcome do
    title { "MyString" }
    details { "MyText" }
    timestamp { "2022-03-13 14:18:15" }
    done { false }
    project_id { nil }
  end
end
