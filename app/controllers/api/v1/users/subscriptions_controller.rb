class Api::V1::Users::SubscriptionsController < ApplicationController
  def index
    user = User.find(params[:id])
    user_subscriptions = SubscriptionsData.new(user.subscriptions)
    render json: SubscriptionSerializer.subscriptions_list(user, user_subscriptions)
  end
end