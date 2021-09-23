# README

## Description
This is a backend API app for a mock tea subscription service. There are currently only three endpoints as a minimal viable product:

- An endpoint to subscribe a customer to a tea subscription
- An endpoint to cancel a customer’s tea subscription
- An endpoint to see all of a customer’s subsciptions (active and cancelled)

This project was worked on over about two days. 

### Ruby version
- Ruby 2.7.2
- Rails 6.1.4.1

### System dependencies
- `gem 'factory_bot_rails'`
- `gem 'faker'`
- `gem 'rspec-rails'`
- `gem 'simplecov'`
- `gem 'pry'`
- `gem 'awesome_print'`
- `gem 'shoulda-matchers', '~> 3.1'`
- `gem 'rubocop-rails'`
- `gem 'jsonapi-serializer'`

### Database creation
- In the command line, type in `ails db:{drop,create,migrate}` to set up your local environment database

### How to run the test suite
- In the command line, type in `bundle install` to properly install the ruby gems. To run the test, type in `bundle exec rspec` in the command line to run the test and check the test coverage.
  
# Requests and Responses

### An endpoint to subscribe a customer to a tea subscription
#### Example Request
`POST "/api/v1/users/#{user_1.id}/subscriptions", params { title: 'Jasmine Premium', price: 10.24, tea_id: 1, status: 'Active', frequency: 'Every two weeks' }`

#### Example Response
````json
{
"data": { 
   "id": "subscription id",
   "type": "user tea subscription",
   "attributes": {
      "title": "Jasmine Tea Premium",
      "price": 10.24,
      "status": "Active",
      "frequency": "Every two weeks"
      }
   }
}
````

### An endpoint to show a customer updated a tea subscription
#### Example Request
`PATCH "/api/v1/users/#{user_1.id}/subscriptions/#{subscription_1.id}", params { status: 'Cancelled' }`

#### Example Response
````json
{
"data": { 
   "id": "subscription id",
   "type": "subscription",
   "attributes": {
      "title": "Jasmine Tea Premium",
      "price": 10.24,
      "status": "Cancelled",
      "frequency": "Every two weeks",
      "tea_id": "tea.id",
      "user_id": "user.id"
      }
   }
}
````

### An endpoint to display a list of a customer's subscriptions
#### Example Request
`GET "/api/v1/users/#{user_1.id}/subscriptions"`

#### Example Response
````json
{
  "data": { 
     "id": "user_1.id",
     "name": "user name",
     "email": "user email",
     "type": "user subscriptions",
     "attributes": {
       "subscriptions": [ {
          "title": "Jasmine Tea Premium",
          "price": 10.24,
          "status": "Active",
          "frequency": "Every two weeks"
        }, 
        {
          "title": "Green Tea Standard",
          "price": 5.82,
          "status": "Active",
          "frequency": "Every three weeks"
      } ]
    }
  }
}
````
