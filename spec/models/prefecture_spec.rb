require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  context "Associations" do
    it "should has many spots" do
      association = described_class.reflect_on_association(:spots)
      expect(association.macro).to eq :has_many
    end
  end
end
