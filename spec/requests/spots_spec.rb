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

    it "詳細ページを表示されていること" do
      (0... SpotsController::SPOT_LIMIT - 1).each do |i|
        params = {}
        params[:id] = spots[i].id
        get(spot_path(spots[i].id), params: params)
        expect(response).to render_template("spots/show")
      end
    end
  end

  describe '検索' do
    subject do
      get search_spots_path, params: { q: {
        spot_schedules_start_on_gteq: spot_schedules_start_on_gteq,
        spot_schedules_end_on_lteq: spot_schedules_end_on_lteq,
        prefecture_name_eq: prefecture_name_eq,
        tag_name_in: tag_name_in,
        spot_reviews_count_gt: spot_reviews_count_gt
      }}
      response.body
    end

    let(:spot_schedules_start_on_gteq) {}
    let(:spot_schedules_end_on_lteq) {}
    let(:prefecture_name_eq) {}
    let(:tag_name_in) {}
    let(:spot_reviews_count_gt) {}

    let!(:spot1) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 2, start_on: Time.zone.now - 11.days, end_on: Time.zone.now - 5.days)
    end

    let!(:spot2) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 10, start_on: Time.zone.now - 9.days, end_on: Time.zone.now - 4.days)
    end

    let!(:spot3) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 15, start_on: Time.zone.now - 8.days, end_on: Time.zone.now - 3.days)
    end

    let!(:spot4) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 21, start_on: Time.zone.now - 7.days, end_on: Time.zone.now - 2.days)
    end

    let!(:spot5) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, reviews_count: 6, start_on: Time.zone.now - 6.days, end_on: Time.zone.now)
    end

    it '日付とタグと都道府県を指定することが表示されていること' do
      is_expected.to have_selector('input#q_spot_schedules_start_on_gteq')
      is_expected.to have_selector('input#q_spot_schedules_end_on_lteq')
      is_expected.to have_selector("select#q_prefecture_name_eq")
      is_expected.to have_selector("select#q_tag_name_in")
    end

    context 'start_onが適当じゃない' do
      let(:spot_schedules_start_on_gteq) { Time.zone.now }
      let(:spot_schedules_end_on_lteq) { Time.zone.now + 7.days }
    
      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot1.name)
        is_expected.not_to have_content(spot2.name)
        is_expected.not_to have_content(spot3.name)
        is_expected.not_to have_content(spot4.name)
        is_expected.not_to have_content(spot5.name)
      end
    end

    context 'end_onが適当じゃない' do
      let(:spot_schedules_start_on_gteq) { Time.zone.now - 9.days }
      let(:spot_schedules_end_on_lteq) { Time.zone.now - 7.days }

      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot1.name)
        is_expected.not_to have_content(spot2.name)
        is_expected.not_to have_content(spot3.name)
        is_expected.not_to have_content(spot4.name)
        is_expected.not_to have_content(spot5.name)
      end
    end

    context 'start_onとend_onが適当' do
      let(:spot_schedules_start_on_gteq) { Time.zone.now - 10.days }
      let(:spot_schedules_end_on_lteq) { Time.zone.now - 1.days }
      
      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot1.name)
        is_expected.not_to have_content(spot5.name)
        is_expected.to have_content(spot2.name)
        is_expected.to have_content(spot3.name)
        is_expected.to have_content(spot4.name)
      end
    end

    context '都道府県名が適当' do
      let(:prefecture_name_eq) {spot1.prefecture.name}

      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot2.name)
        is_expected.not_to have_content(spot3.name)
        is_expected.not_to have_content(spot4.name)
        is_expected.not_to have_content(spot5.name)
        is_expected.to have_content(spot1.name)
      end
    end

    context 'タグが適当' do
      let(:tag_name_in) {spot2.tag.name}

      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot1.name)
        is_expected.not_to have_content(spot3.name)
        is_expected.not_to have_content(spot4.name)
        is_expected.not_to have_content(spot5.name)
        is_expected.to have_content(spot2.name)
      end
    end

    context 'タグが2つが適当' do
      let(:tag_name_in) {[spot1.tag.name, spot2.tag.name]}

      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot3.name)
        is_expected.not_to have_content(spot4.name)
        is_expected.not_to have_content(spot5.name)
        is_expected.to have_content(spot1.name)
        is_expected.to have_content(spot2.name)
      end
    end

    context 'レビュー数が適当' do
      let(:spot_reviews_count_gt) { 10 }
      
      it '検索結果が正しいこと' do
        is_expected.not_to have_content(spot1.name)
        is_expected.not_to have_content(spot2.name)
        is_expected.not_to have_content(spot5.name)
        is_expected.to have_content(spot3.name)
        is_expected.to have_content(spot4.name)
      end
    end
  end

  describe '詳細' do
    let!(:spot1) do
      FactoryBot.create(:spot, :with_spot_review, :with_spot_schedule, :with_spot_equipment, reviews_count: 6, start_on: Time.zone.now - 7.days, end_on: Time.zone.now - 2.days, equipment_count: 2)
    end

    before(:each) do
      get root_path
      get spot_path(spot1.id), params: {id: spot1.id}
    end

    it "リクエストが成功すること" do
      expect(response).to have_http_status(200)
    end

    it "spotの名前が表示されていること" do
      expect(response.body).to include(spot1.name)
    end

    it "spotのbodyが表示されていること" do
      expect(response.body).to include(spot1.body)
    end

    it "prefectureの名前が表示されていること" do
      expect(response.body).to include(spot1.prefecture.name)
    end

    it "tag_nameが表示されていること" do
      expect(response.body).to include(spot1.spot_tag.tag.name)
    end

    it "spot_equipmentが表示されていること" do
      spot1.spot_equipments.each do |spot_equipment|
        expect(response.body).to include(spot_equipment.name)
        expect(response.body).to include(spot_equipment.qty)
        expect(response.body).to include(spot_equipment.note)
      end
    end

    it "レビュー全部が表示されていること" do
      expect(response.body).to have_content(spot1.spot_reviews_count)
    end

    it "レビューの内容が表示されていること" do
      (0... spot1.spot_reviews_count - 1).each do |i|
        expect(response.body).to have_content(spot1.spot_reviews[i].comment)
      end
    end
  end
end
