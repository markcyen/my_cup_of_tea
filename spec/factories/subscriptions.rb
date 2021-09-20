FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1.5 }
    status { 1 }
    frequency { "MyString" }
    user { nil }
    tea { nil }
  end
end
