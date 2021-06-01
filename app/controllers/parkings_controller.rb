class ParkingsController < ApplicationController

  def show
    @parking = Parking.find(params[:id])
    authorize @parking
    @reviews = @parking.reviews
  end

end
