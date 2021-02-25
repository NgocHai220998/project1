class SpotsController < ApplicationController
  def index
    @spots = Spot.includes(:prefecture, {:spot_tag => :tag}).page(params[:page]).per(30)
  end
end
