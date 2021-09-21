FactoryBot.define do
  factory :tea do
    variety { Faker::Tea.variety }
    description { Faker::Movies::StarWars.quote }
    temperature { Faker::Number.within(range: -50..150) }
    brew_time { Faker::Time.backward(days: 2, period: :morning, format: :short) }
  end
end
