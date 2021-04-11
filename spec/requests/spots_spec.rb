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
        recent_review = spots[i].spot_review.order(posted_at: :desc).first(3)
        (0... recent_review.count - 1).each do |j|
          expect(recent_review[j].comment.truncate(20).length).to eq(20)
          expect(response.body).to have_content(recent_review[j].comment.truncate(20))
          expect(response.body).not_to have_content(recent_review[j].comment[20..-1])
        end
      end
    end

    it "レビューを日付によってソートされている" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        review = spots[i].spot_review.order(posted_at: :desc)
        (0... review.count - 1).each do |j|
          expect(review[j].posted_at).to be >=review[j+1].posted_at
        end
      end
    end

    it "3つ以上レビューのspotが3つだけ表示されている" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        if(spots[i].spot_reviews_count>=3)
          recent_review = spots[i].spot_review.order(posted_at: :desc).first(3)
          expect(recent_review.count).to eq(3)
          (0... 2).each do |j|
            expect(response.body).to include(recent_review[j].comment.truncate(20))
          end
        end
      end
    end

    it "3つ以下レビューのspotが全部表示されている" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        if(spots[i].spot_reviews_count<3)
          (0... spots[i].spot_reviews_count - 1).each do |j|
            expect(response.body).to include(spots[i].spot_review[j].comment.truncate(20))
          end
        end
      end
    end
  end
end
