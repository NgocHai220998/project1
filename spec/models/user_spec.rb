require 'rails_helper'

RSpec.describe User, type: :model do
  context "Associations" do
    it "should has many spot_reviews" do
      association = described_class.reflect_on_association(:spot_reviews)
      expect(association.macro).to eq :has_many
    end
  end
end
