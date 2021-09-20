require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    [:full_name, :email, :address].each do |attribute|
      it { should validate_presence_of attribute }
    end
    
    it { should validate_uniqueness_of :email }
  end

  describe "relationships" do
    it {should have_many :subscriptions}
  end
end
