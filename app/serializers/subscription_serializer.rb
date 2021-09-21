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
end
