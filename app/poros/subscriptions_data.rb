class SubscriptionsData
  attr_reader :subscriptions

  def initialize(data)
    @subscriptions = data.map do |subscription|
      {
        id: subscription.id,
        title: subscription.title,
        price: subscription.price,
        status: subscription.status,
        frequency: subscription.frequency
      }
    end
  end
end