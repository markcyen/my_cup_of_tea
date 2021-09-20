FactoryBot.define do
  factory :subscription do
    title { Faker::Subscription.plan }
    price { Faker::Number.decimal(l_digits: 2) }
    status { Faker::Subscription.status }
    frequency { Faker::Subscription.payment_term }
    association :user, factory: :user
    association :tea, factory: :tea
  end
end
