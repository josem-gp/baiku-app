class ParkingsController < ApplicationController

  def index
    @parkings = policy_scope(Parking)
    if params[:query].present?
      @parkings = Parking.search_by_name_and_address(params[:query])
    end
    @markers = @parkings.geocoded.map do |parking|
      {
        lat: parking.latitude,
        lng: parking.longitude,
        info_window: render_to_string(partial: "info_window", locals: { parking: parking }),
        marker: render_to_string(partial: "marker", locals: { parking: parking })
      }
    end
    # if params[:to_parking].present?
    #   @parking = Parking.find(params[:to_parking])
    #   @destination = [@parking.longitude, @parking.latitude]
    # else
    #   @destination = [139.6925947, 35.6324644]
    # end
  end

  def show
    @parking = Parking.find(params[:id])
    authorize @parking
    @reviews = @parking.reviews
  end
end
