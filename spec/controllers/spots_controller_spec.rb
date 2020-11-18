require	'rails_helper'

RSpec.describe SpotsController,	type:	:controller	do
  @prefecture = FactoryBot.create(:prefecture)
  @spot = FactoryBot.create(:spot, :prefecture => @prefecture)
  describe "index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "display all spots" do
      get :index
      expect(assigns(:spot)).to eq @spot
    end
  end
end
