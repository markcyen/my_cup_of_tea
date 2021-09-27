class User < ApplicationRecord
  validates :full_name, :email, :address, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :subscriptions, dependent: :destroy
end
