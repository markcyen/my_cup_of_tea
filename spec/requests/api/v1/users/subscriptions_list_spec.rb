require 'rails_helper'

RSpec.describe 'User Subscriptions List API' do
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

  describe 'user subscriptions list endpoint' do
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
end