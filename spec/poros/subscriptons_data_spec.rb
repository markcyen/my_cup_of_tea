require 'rails_helper'

RSpec.describe SubscriptionsData do
  describe 'initialize' do
    it 'abstracts and encapsulates user subscriptions data' do
      user_1 = create(:user)
      tea_1 = create(:tea, variety: 'Green Tea')
      tea_2 = create(:tea, variety: "Earl Grey")
      subscription_1 = create(:subscription, title: "Premium", user: user_1, tea: tea_1, status: 'Active')
      subscription_2 = create(:subscription, title: "Standard", user: user_1, tea: tea_2, status: 'Cancelled')

      user_1_subscriptions = SubscriptionsData.new(user_1.subscriptions).subscriptions

      subscription_1_data = {
          'id': subscription_1.id,
          'title': subscription_1.title,
          'price': subscription_1.price,
          'status': subscription_1.status,
          'frequency': subscription_1.frequency
        }
      
      subscription_2_data = {
        'id': subscription_2.id,
        'title': subscription_2.title,
        'price': subscription_2.price,
        'status': subscription_2.status,
        'frequency': subscription_2.frequency
      }


      expect(user_1_subscriptions).to include(subscription_1_data)
      expect(user_1_subscriptions).to include(subscription_2_data)
    end
  end
end