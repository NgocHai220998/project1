class SpotsController < ApplicationController
  SPOT_LIMIT = 30

  def index
    @spots = Spot.includes(:prefecture, spot_tag: :tag).page(params[:page]).per(SPOT_LIMIT)
  end
end
