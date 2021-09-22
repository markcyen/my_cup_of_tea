class SubscriptionSerializer
  include JSONAPI::Serializer
  
  def self.subscriptions_list(user_data, user_subscriptions)
    {
      data: {
        id: user_data.id,
        name: user_data.full_name,
        email: user_data.email,
        type: 'user subscriptions',
        attributes: user_subscriptions
      }
    }
  end

  def self.activate(user, tea, new_subscription)
    {
      data: {
        id: user.id,
        name: user.full_name,
        email: user.email,
        tea: tea.variety,
        type: 'user new subscription',
        message: 'New subscription successfully created!',
        attributes: new_subscription
      }
    }
  end
end
