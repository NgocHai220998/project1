class SpotsController < ApplicationController
  SPOT_LIMIT = 30

  before_action :spot_params, only: %i[index search]

  def index
    @spots = includes_table(Spot)
  end

  def search
    @spots = includes_table(@q.result)
    render :index
  end

  private

  def spot_params
    @q = Spot.ransack(params[:q])
  end

  def includes_table(table)
    table.includes(:prefecture, spot_tag: :tag).page(params[:page]).per(SPOT_LIMIT)
  end

  def show
    @spot = Spot.find(params[:id])
    puts params
  end
end
