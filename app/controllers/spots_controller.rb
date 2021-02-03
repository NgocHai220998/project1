class SpotsController < ApplicationController
  def index
    @spots = Spot.page(params[:page]).per(30)
  end
end
