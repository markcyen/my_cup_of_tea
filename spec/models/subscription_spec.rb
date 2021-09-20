require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'validations' do
    [:title, :price, :status, :frequency].each do |attribute|
      it { should validate_presence_of attribute }
    end

    it { should validate_numericality_of :price }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :tea }
  end
end
