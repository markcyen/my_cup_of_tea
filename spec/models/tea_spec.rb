require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "validations" do
    [:variety, :description, :temperature, :brew_time_in_min].each do |attribute|
      it { should validate_presence_of attribute }
    end

    it { should validate_numericality_of(:temperature).only_integer }
    it { should validate_numericality_of(:temperature).is_greater_than_or_equal_to(-50) }
    it { should validate_numericality_of(:temperature).is_less_than_or_equal_to(150) }
  end

  describe "relationships" do
    it { should have_many :subscriptions }
  end
end
