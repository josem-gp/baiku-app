class ParkingsController < ApplicationController

  def index
    @parkings = policy_scope(Parking)
    authorize @parkings
    @markers = @parkings.geocoded.map do |parking|
      {
        lat: parking.latitude,
        lng: parking.longitude,
        info_window: render_to_string(partial: "info_window", locals: { parking: parking })
      }
    end
  end

  def show
    @parking = Parking.find(params[:id])
  end

end
