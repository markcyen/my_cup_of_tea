# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Tea.destroy_all
Subscription.destroy_all

user_1 = User.create(
  full_name: 'Ted Lasso',
  email: 'tedlasso@test.com',
  address: '123 Main Ave, NY, NY 03820'
)

user_2 = User.create(
  full_name: 'Coach Beard',
  email: 'coachbeard@test.com',
  address: '456 Main Ave, NY, NY 03534'
)

tea_1 = Tea.create(variety: 'Green Tea', description: 'Smooth', temperature: 104, brew_time_in_min: 3.4)
tea_2 = Tea.create(variety: 'Jasmine', description: 'Light', temperature: 101, brew_time_in_min: 5.3)
tea_3 = Tea.create(variety: 'Earl Grey', description: 'Dark', temperature: 93, brew_time_in_min: 7.2)
tea_4 = Tea.create(variety: 'Sleepy Time', description: 'Silky', temperature: 98, brew_time_in_min: 5.2)
tea_5 = Tea.create(variety: 'Rose', description: 'Refreshing', temperature: 106, brew_time_in_min: 6.3)
tea_6 = Tea.create(variety: 'Black Tea', description: 'Lovely', temperature: 99, brew_time_in_min: 4.8)
tea_7 = Tea.create(variety: 'Oolong', description: 'Bitter', temperature: 94, brew_time_in_min: 2.7)

subscription_1 =  Subscription.create(title: "#{tea_1.variety} Premium", price: 12.24, status: 'Active', frequency: 'Weekly', tea_id: tea_1.id, user_id: User.first.id)
subscription_2 =  Subscription.create(title: "#{tea_2.variety} Standard", price: 9.24, status: 'Active', frequency: 'Bi-weekly', tea_id: tea_2.id, user_id: User.first.id)
subscription_3 =  Subscription.create(title: "#{tea_3.variety} Prime", price: 15.24, status: 'Cancelled', frequency: 'Monthly', tea_id: tea_3.id, user_id: User.first.id)
subscription_4 =  Subscription.create(title: "#{tea_4.variety} Bonus", price: 13.24, status: 'Active', frequency: 'Monthly', tea_id: tea_4.id, user_id: User.last.id)
