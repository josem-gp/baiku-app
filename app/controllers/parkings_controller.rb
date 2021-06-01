class ParkingsController < ApplicationController

  def index
    @parkings = policy_scope(Parking)
    authorize @parkings
    @markers = @parkings.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @parking = Parking.find(params[:id])
    authorize @parking
    @reviews = @parking.reviews
  end
end
