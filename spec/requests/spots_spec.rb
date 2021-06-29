require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do
    let!(:spots){ FactoryBot.create_list(:spot, 31, :with_spot_review)}

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
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        expect(spots[i].body.truncate(30).length).to eq(30)
        expect(response.body).to have_content(spots[i].body.truncate(30))
        expect(response.body).not_to have_content(spots[i].body[30..-1])
      end
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

    it "レビューのコメントが20字以内で表示されていること" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        spots[i].spot_reviews.first(3).each do |recent_review|
          expect(recent_review.comment.truncate(20).length).to eq(20)
          expect(response.body).to have_content(recent_review.comment.truncate(20))
          expect(response.body).not_to have_content(recent_review.comment[20..-1])
        end
      end
    end

    it "スケジュールを検索する" do
      byebug
      spot_schedule_start_on = Time.zone.now - rand(5..10).days 
      spot_schedule_end_on = Time.zone.now - rand(15..20).days 
      
      (0... Spot.count-1).each do |i|
        if spots[i].spot_schedule.start_on
        end
      end
    end
  end
end
