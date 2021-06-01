class ParkingsController < ApplicationController

  def show
    @parking = Parking.find(params[:id])
  end

end
