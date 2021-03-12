require 'rails_helper'

RSpec.describe Tag, type: :model do
  context "Associations" do
    it "should has many spot_tags" do
      association = described_class.reflect_on_association(:spot_tag)
      expect(association.macro).to eq :has_many
    end
  end
end
