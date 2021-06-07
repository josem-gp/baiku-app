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
        marker: render_to_string(partial: "marker", locals: { parking: parking })
      }
    end
    if params[:to_parking].present?
      @parking = Parking.find(params[:to_parking])
      @destination = [@parking.longitude, @parking.latitude]
    end
    @parking = Parking.new
  end

  def show
    @parking = Parking.find(params[:id])
    authorize @parking
    @reviews = @parking.reviews
  end

  def create
    @parking = Parking.new(parking_params)
    authorize @parking
    redirect_to parking_path(@parking) if @parking.save
  end

  private

  def parking_params
    params.require(:parking).permit(:name, :address, :description, :photo, :price, :risk_level)
  end
end
