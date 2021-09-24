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

### Setup
- Either fork this repo or `git clone git@github.com:markcyen/my_cup_of_tea.git`. In the command line, type in `bundle install` to properly install the ruby gems.

### Database design
![tea_schema](https://user-images.githubusercontent.com/77414433/134444043-885b5b9b-82ea-4dbd-aa7c-d3334dfa4fd0.jpg)


### External libraries (ruby gems)
In the Gemfile, you will find the following libraries used in this Rails app:
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
- In the command line, type in `rails db:{drop,setup}` to set up your local environment database. Type in `rails server` to run this app in your local environment (ie, `http://localhost:3000`) and append any of the URIs below. Alternatively, this app can test the following resquests and responses in [postman API platform](https://www.postman.com/).

### How to run the test suite
- To run the test, type in `bundle exec rspec` in the command line to run the test and check the test coverage.
  
# Requests and Responses

### An endpoint to subscribe a customer to a tea subscription
#### Example Request
 - General Query: `POST "/api/v1/users/<user.id>/subscriptions?'<Tea Title>'='Jasmine Premium'&'<Tea Price>'=10.24&'<Subscription Status>'='Active'&'<Subscription Frequency>'='Every two weeks'"`

 - Rails-specific Query: `POST "/api/v1/users/<user.id>/subscriptions, params { title: 'Jasmine Premium', price: 10.24, tea_id: 1, status: 'Active', frequency: 'Every two weeks' }`

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
- General Query: `PATCH "/api/v1/users/<user.id>/subscriptions/<subscription.id>?'<Subscription Status>'='Cancelled'"`

- Rails-specific Query: `PATCH "/api/v1/users/<user.id>/subscriptions/<subscription.id>", params { status: 'Cancelled' }`

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
 - General and Rails-specific Query: `GET "/api/v1/users/<user.id>/subscriptions"`

#### Example Response
````json
{
  "data": { 
     "id": "user.id",
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
          "status": "Cancelled",
          "frequency": "Every three weeks"
      } ]
    }
  }
}
````
