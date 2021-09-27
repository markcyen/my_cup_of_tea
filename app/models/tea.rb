class Tea < ApplicationRecord
  validates :variety, :description, :temperature, :brew_time_in_min, presence: true
  validates :temperature, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: -50,
    less_than_or_equal_to: 150
  }

  has_many :subscriptions, dependent: :destroy
end
