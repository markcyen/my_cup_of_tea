require 'rails_helper'

RSpec.describe 'User Subscription Update API' do
  before :each do
    User.destroy_all
    Tea.destroy_all
    Subscription.destroy_all

    @user_1 = create(:user)
    @tea_1 = create(:tea, variety: 'Green Tea')
    @tea_2 = create(:tea, variety: 'Jasmine')

    @subscription_1 = create(:subscription, title: "#{@tea_1.variety} Premium", user: @user_1, tea: @tea_1, status: "Active")
    @subscription_2 = create(:subscription, title: "#{@tea_2.variety} Standard", user: @user_1, tea: @tea_2, status: "Active")
  end

  describe 'update subscription' do
    it 'shows an endpoint where user updates subcription service' do
      subscription_1_update = { 
        status: "Cancelled" 
      }
      patch "/api/v1/users/#{@user_1.id}/subscriptions/#{@subscription_1.id}", params: subscription_1_update

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_data = JSON.parse(response.body, symbolize_names: true)
      update_subscription_1 = json_data[:data][:attributes]

      expect(update_subscription_1[:title]).to eq("#{@tea_1.variety} Premium")
      expect(update_subscription_1[:status]).to eq('Cancelled')
    end

    it 'shows a sad path endpoint' do
      subscription_1_update = { 
        status: "Cancelled" 
      }
      patch "/api/v1/users/#{@user_1.id}/subscriptions/4920", params: subscription_1_update

      expect(response.status).to eq(400)

      json_data = JSON.parse(response.body, symbolize_names: true)

      expect(json_data[:error]).to eq('Bad request!')
      expect(json_data[:status]).to eq('Failed!')
    end
  end
end