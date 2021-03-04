require 'rails_helper'

RSpec.describe Spot, type: :model do
  context "Associations" do
    it "should belongs to prefecture" do
      association = described_class.reflect_on_association(:prefecture)
      expect(association.macro).to eq :belongs_to
    end
  end
end
