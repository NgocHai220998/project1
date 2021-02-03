require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do
    let(:spot_tag) {FactoryBot.create :spot_tag}
    before { FactoryBot.create_list(:spot_tag, 31) }

    it "works! (now write some real specs)" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "tag_name display" do
      expect(spot_tag.tag.name).to eq("高原")
    end

    it "name of prefecture display" do
      expect(spot_tag.spot.prefecture.name).to eq("北海道")
    end

    it "spot name display" do
      expect(spot_tag.spot.name).to eq("原生花園 あやめヶ原")
    end

    it "spot body display 30 characters" do
      expect(spot_tag.spot.body.truncate(30).length).to eq(30)
    end

    it "show pagination" do
      get root_path
      expect(response.body).to have_selector("ul.pagination")
    end
  end
end
