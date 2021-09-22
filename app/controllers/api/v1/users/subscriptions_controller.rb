class Api::V1::Users::SubscriptionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    user_subscriptions = SubscriptionsData.new(user.subscriptions)
    render json: SubscriptionSerializer.subscriptions_list(user, user_subscriptions), status: :ok
  end

  def create
    begin
      user = User.find(params[:user_id])
      tea = Tea.find(params[:tea_id])
      new_subscription = user.subscriptions.create(new_subscription_params)

      render json: SubscriptionSerializer.activate(user, tea, new_subscription), status: :created
    rescue ActiveRecord::RecordNotFound
      render json: {
        error: 'Bad request!',
        status: 'Failed!'
      }, status: :bad_request
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
      subscription.update(new_subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: {
        error: 'Bad request!',
        status: 'Failed!'
      }, status: :bad_request
    end
  end

  private

  def new_subscription_params
    params.permit(:title, :price, :frequency, :status, :tea_id)
  end
end