class Subscription < ApplicationRecord
  validates :title, :price, :status, :frequency, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  belongs_to :tea
end
