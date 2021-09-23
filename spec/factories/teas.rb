FactoryBot.define do
  factory :tea do
    variety { Faker::Tea.variety }
    description { Faker::Movies::StarWars.quote }
    temperature { Faker::Number.within(range: -50..150) }
    brew_time_in_min { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
