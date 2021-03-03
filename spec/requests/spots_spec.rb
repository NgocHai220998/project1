require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do 
    let!(:spot_tags){ FactoryBot.create_list(:spot_tag, 31) }
    before(:each) do
      get root_path
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "tag_nameが表示されていること" do
      expect(response.body).to include(spot_tags[0].tag.name)
    end

    it "prefectureの名前が表示されていること" do
      expect(response.body).to include(spot_tags[0].spot.prefecture.name)
    end

    it "spotの名前が表示されていること" do
      expect(response.body).to include(spot_tags[0].spot.name)
    end

    it "spotのbodyが30字以内で表示されていること" do
      expect(spot_tags[0].spot.body.truncate(30).length).to eq(30)
      expect(response.body).to have_content(spot_tags[0].spot.body.truncate(30))
      byebug
    end

    it "ページネーションが表示されていること" do
      expect(response.body).to have_selector("ul.pagination")
    end

    it "ページ2を表示されていること" do
      get "/?page=2"
      expect(response.body).to include(spot_tags[30].spot.name)
    end
  end
end
