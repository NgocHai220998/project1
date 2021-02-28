require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do 
    let(:spot_tag) {FactoryBot.create :spot_tag}
    before { FactoryBot.create_list(:spot_tag, 31) }
    before(:each) do
      get root_path
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "tag_nameが表示されていること" do
      expect(spot_tag.tag.name).to eq("高原")
      expect(response.body).to include("高原")
    end

    it "prefectureの名前が表示されていること" do
      expect(spot_tag.spot.prefecture.name).to eq("北海道")
      expect(response.body).to include("北海道")
    end

    it "spotの名前が表示されていること" do
      expect(spot_tag.spot.name).to eq("原生花園 あやめヶ原")
      expect(response.body).to include("原生花園 あやめヶ原")
    end

    it "spotのbodyが30字以内で表示されていること" do
      expect(spot_tag.spot.body.truncate(30).length).to eq(30)
      expect(response.body).to include("厚岸海岸チンベの鼻一帯の台地上に")
    end

    it "ページネーションが表示されていること" do
      expect(response.body).to have_selector("ul.pagination")
    end

    it "ページ2を表示されていること" do
      get "/?page=2"
      expect(response.body).to include("北海道")
    end
  end
end
