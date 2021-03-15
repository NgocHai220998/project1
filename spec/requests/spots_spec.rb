require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do 
    let!(:spots){ FactoryBot.create_list(:spot, 31) }

    before(:each) do
      get root_path
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "tag_nameが表示されていること" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        expect(response.body).to include(spots[i].tag.name)
      end
    end

    it "prefectureの名前が表示されていること" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        expect(response.body).to include(spots[i].prefecture.name)
      end
    end

    it "spotの名前が表示されていること" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        expect(response.body).to include(spots[i].name)
      end
    end

    it "spotのbodyが30字以内で表示されていること" do
      expect(spots[0].body.truncate(30).length).to eq(30)
      expect(response.body).to have_content(spots[0].body.truncate(30))
      expect(response.body).not_to have_content(spots[0].body[30..-1])
    end

    it "ページネーションが表示されていること" do
      expect(response.body).to have_selector("ul.pagination")
    end

    it "ページ2を表示されていること" do
      get root_path(page: 2)
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        expect(response.body).not_to include(spots[i].name)
      end
    end

    it "レビューの総数を表示されていること" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        expect(response.body).to have_content(spots[i].spot_reviews_count)
      end
    end
  end
end
