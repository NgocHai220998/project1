require 'rails_helper'

RSpec.describe SpotReview, type: :model do
  context "Associations" do
    it "should belongs to spot" do
      association = described_class.reflect_on_association(:spot)
      expect(association.macro).to eq :belongs_to
    end
  end
end
