FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Movies::StarWars.quote }
    temperature { Faker::Number.within(range: -50..200) }
    brew_time { "2021-09-20 11:08:04" }
  end
end
