class ParkingsController < ApplicationController

  def show
    @parking = Parking.new(params[:id])
    authorize @parking
  end

end
