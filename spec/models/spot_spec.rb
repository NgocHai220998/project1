require 'rails_helper'

RSpec.describe Spot, type: :model do
  context "Associations" do
    it "should belongs to prefecture" do
      association = described_class.reflect_on_association(:prefecture)
      expect(association.macro).to eq :belongs_to
    end

    it "should has many spot_reviews" do
      association = described_class.reflect_on_association(:spot_reviews)
      expect(association.macro).to eq :has_many
    end

    it "should has one spot_tag" do
      association = described_class.reflect_on_association(:spot_tag)
      expect(association.macro).to eq :has_one
    end

    it "should has one tag" do
      association = described_class.reflect_on_association(:tag)
      expect(association.macro).to eq :has_one
    end

    it "should has many spot_schedule" do
      association = described_class.reflect_on_association(:spot_schedules)
      expect(association.macro).to eq :has_many
    end
  end
end
