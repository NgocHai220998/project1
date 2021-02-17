class SpotsController < ApplicationController
  def index
    @spots = Spot.includes(:prefecture).page(params[:page]).per(30)
  end
end
