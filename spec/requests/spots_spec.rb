require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Spots", type: :request do
  describe "GET /spots" do
    let!(:spots){ FactoryBot.create_list(:spot, 31, :with_spot_review, :with_spot_schedule)}

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
  end

  describe "検索" do
    let!(:spot1) do
      spot = FactoryBot.create(:spot)
      FactoryBot.create(:spot_schedule, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days, spot: spot)
      spot
    end

    let!(:spot2) do
      spot = FactoryBot.create(:spot)
      FactoryBot.create(:spot_schedule, start_on: Time.zone.now - 9.days, end_on: Time.zone.now - 4.days, spot: spot)
      spot
    end

    let!(:spot3) do
      spot = FactoryBot.create(:spot)
      FactoryBot.create(:spot_schedule, start_on: Time.zone.now - 8.days, end_on: Time.zone.now - 3.days, spot: spot)
      spot
    end

    let!(:spot4) do
      spot = FactoryBot.create(:spot)
      FactoryBot.create(:spot_schedule, start_on: Time.zone.now - 7.days, end_on: Time.zone.now - 2.days, spot: spot)
      spot
    end

    let!(:spot5) do
      spot = FactoryBot.create(:spot)
      FactoryBot.create(:spot_schedule, start_on: Time.zone.now - 6.days, end_on: Time.zone.now, spot: spot)
      spot
    end

    before(:each) do
      get root_path
    end

    it "日付を指定することが表示されていること" do
      expect(response.body).to have_selector("input#q_spot_schedules_start_on_gteq")
      expect(response.body).to have_selector("input#q_spot_schedules_end_on_lteq")
    end

    it "start_onが適当じゃない" do
      params = {}
      params[:q] = {"spot_schedules_start_on_gteq"=> Time.zone.now, "spot_schedules_end_on_lteq"=> Time.zone.now + 7.days}

      get(search_spots_path, params: params)
      expect(response.body).not_to have_content(spot1.name)
      expect(response.body).not_to have_content(spot2.name)
      expect(response.body).not_to have_content(spot3.name)
      expect(response.body).not_to have_content(spot4.name)
      expect(response.body).not_to have_content(spot5.name)
    end

    it "end_onが適当じゃない" do
      params = {}
      params[:q] = {"spot_schedules_start_on_gteq"=> Time.zone.now - 9.days, "spot_schedules_end_on_lteq"=> Time.zone.now - 7.days}

      get(search_spots_path, params: params)

      expect(response.body).not_to have_content(spot1.name)
      expect(response.body).not_to have_content(spot2.name)
      expect(response.body).not_to have_content(spot3.name)
      expect(response.body).not_to have_content(spot4.name)
      expect(response.body).not_to have_content(spot5.name)
    end

    it "start_onとend_onが適当" do
      params = {}
      params[:q] = {"spot_schedules_start_on_gteq"=> Time.zone.now - 10.days, "spot_schedules_end_on_lteq"=> Time.zone.now - 1.days}

      get(search_spots_path, params: params)
      
      expect(response.body).not_to have_content(spot1.name)
      expect(response.body).to have_content(spot2.name)
      expect(response.body).to have_content(spot3.name)
      expect(response.body).to have_content(spot4.name)
      expect(response.body).not_to have_content(spot5.name)
    end

    it "検索した後、indexに移動する" do
      params = {}
      params[:q] = {"spot_schedules_start_on_gteq"=> Time.zone.now - rand(6..10).days, "spot_schedules_end_on_lteq"=> Time.zone.now - rand(1..5).days}

      get(search_spots_path, params: params)
      expect(response).to render_template('spots/index')
    end
  end
end
