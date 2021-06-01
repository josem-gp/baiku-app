class ParkingsController < ApplicationController

  def show
    @parking = Parking.find(params[:id])
    authorize @parking
  end

end
