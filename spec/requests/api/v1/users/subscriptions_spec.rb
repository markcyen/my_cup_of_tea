require 'rails_helper'

RSpec.describe 'User Subscriptions API' do
  before :each do
    User.destroy_all
    Tea.destroy_all
    Subscription.destroy_all

    @user_1 = create(:user)
    @tea_1 = create(:tea, variety: 'Green Tea')
    @tea_2 = create(:tea, variety: 'Jasmine')
    @tea_3 = create(:tea, variety: 'Earl Grey')
    @tea_4 = create(:tea, variety: 'Rose Tea')

    @subscription_1 = create(:subscription, title: "#{@tea_1.variety} Premium", user: @user_1, tea: @tea_1, status: "Active")
    @subscription_3 = create(:subscription, title: "#{@tea_3.variety} Standard", user: @user_1, tea: @tea_3, status: "Cancelled")
  end

  describe 'user subscriptions endpoint' do
    it 'has a successful response' do
      get "/api/v1/users/#{@user_1.id}/subscriptions"

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'successfully identifies the class of the serialized data' do
      get "/api/v1/users/#{@user_1.id}/subscriptions"
      user_1_json = JSON.parse(response.body, symbolize_names: true)

      expect(user_1_json[:data]).to be_a Hash
      expect(user_1_json[:data][:attributes]).to be_a Hash
      expect(user_1_json[:data][:attributes][:subscriptions]).to be_an Array
    end

    it 'can list user data' do
      get "/api/v1/users/#{@user_1.id}/subscriptions"
      user_1_json = JSON.parse(response.body, symbolize_names: true)

      expect(user_1_json[:data][:id]).to eq(@user_1.id)
      expect(user_1_json[:data][:name]).to eq(@user_1.full_name)
      expect(user_1_json[:data][:email]).to eq(@user_1.email)
      expect(user_1_json[:data][:type]).to eq('user subscriptions')
    end

    it 'can list user subscriptions' do
      get "/api/v1/users/#{@user_1.id}/subscriptions"
      user_1_json = JSON.parse(response.body, symbolize_names: true)
      subscriptions = user_1_json[:data][:attributes][:subscriptions]

      subscription_1 = {
        'title': @subscription_1.title,
        'price': @subscription_1.price,
        'status': @subscription_1.status,
        'frequency': @subscription_1.frequency
      }

      subscription_3 = {
        'title': @subscription_3.title,
        'price': @subscription_3.price,
        'status': @subscription_3.status,
        'frequency': @subscription_3.frequency
      }

      expect(subscriptions).to include(subscription_1)
      expect(subscriptions).to include(subscription_3)
    end
  end

  describe 'new tea subscription' do
    it 'user does not have subscription two' do
      get "/api/v1/users/#{@user_1.id}/subscriptions"
      user_1_json = JSON.parse(response.body, symbolize_names: true)
      subscriptions = user_1_json[:data][:attributes][:subscriptions]

      subscription_2 = {
        'title': "#{@tea_2.variety} Premium",
        'price': 13.7,
        'status': 'Active',
        'frequency': 'Monthly'
      }

      expect(subscriptions).not_to include(subscription_2)
    end

    it 'user subscribes to a new tea subscription with successful message' do
      new_subscription_2 = {
        title: "#{@tea_2.variety} Premium",
        price: 13.7,
        tea_id: @tea_2.id,
        status: 'Active',
        frequency: 'Monthly'
      }
      post "/api/v1/users/#{@user_1.id}/subscriptions", params: new_subscription_2
      
      expect(response).to be_successful
      expect(response.status).to eq(201)

      created_new_subscription_2 = JSON.parse(response.body, symbolize_names: true)

      expect(created_new_subscription_2[:data][:message]).to eq('New subscription successfully created!')
      expect(created_new_subscription_2[:data][:attributes][:title]).to eq("#{@tea_2.variety} Premium")
      expect(created_new_subscription_2[:data][:attributes][:price]).to eq(13.7)
      expect(created_new_subscription_2[:data][:attributes][:status]).to eq('Active')
    end

    it 'shows the most recent new subsctiption on the list' do
      new_subscription_2 = {
        title: "#{@tea_2.variety} Premium",
        price: 13.7,
        tea_id: @tea_2.id,
        status: 'Active',
        frequency: 'Monthly'
      }
      post "/api/v1/users/#{@user_1.id}/subscriptions", params: new_subscription_2

      get "/api/v1/users/#{@user_1.id}/subscriptions"

      user_1_json = JSON.parse(response.body, symbolize_names: true)
      subscriptions = user_1_json[:data][:attributes][:subscriptions]

      subscription_2 = {
        'title': "#{@tea_2.variety} Premium",
        'price': 13.7,
        'status': 'Active',
        'frequency': 'Monthly'
      }

      expect(subscriptions.last).to eq(subscription_2)
    end

    it 'returns a bad request if params are not sufficient' do
      fake_subscription = {
        title: "#{@tea_2.variety} Premium",
        price: 13.7,
        tea_id: 1029342,
        status: 'Active',
        frequency: 'Monthly'
      }

      post "/api/v1/users/#{@user_1.id}/subscriptions", params: fake_subscription

      expect(response.status).to eq(400)

      new_subscription_attempt = JSON.parse(response.body, symbolize_names: true)
      
      expect(new_subscription_attempt[:error]).to eq('Bad request!')
      expect(new_subscription_attempt[:status]).to eq('Failed!')
    end
  end
end