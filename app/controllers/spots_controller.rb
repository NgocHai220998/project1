class SpotsController < ApplicationController
  def index
    @spots = Spot.all.page(params[:page]).per(30)
  end
end
