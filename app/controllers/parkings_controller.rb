class ParkingsController < ApplicationController
  before_action :authenticate_user!, only: :toggle_favorite

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
      @markers = [{
                    lat: @parking.latitude,
                    lng: @parking.longitude,
                    marker: render_to_string(partial: "marker", locals: { parking: @parking })
      }]
    end
    @favorite_parkings = current_user.favorited_by_type('Parking')
  end

  def show
    @parking = Parking.find(params[:id])
    authorize @parking
    @reviews = @parking.reviews
    @review = Review.new
  end

  def new
    @parking = Parking.new
    authorize @parking
  end

  def create

    @parking = Parking.new(parking_params)
    authorize @parking
    if @parking.save
      gps_latitude = MiniMagick::Image.open(@parking.photos.first).exif["GPSLatitude"]
      result = gps_latitude.split(',')
      latitude_sum = (result[0].split("/")[0].to_i) + ((result[1].split("/")[0].to_i)/60.0) +  (((result[2].split("/")[0].to_i)/(result[2].split("/")[1]).to_f)/3600.0)
      @parking.latitude = latitude_sum

      gps_longitude = MiniMagick::Image.open(@parking.photos.first).exif["GPSLongitude"]
      result = gps_longitude.split(',')
      longitude_sum = (result[0].split("/")[0].to_i) + ((result[1].split("/")[0].to_i)/60.0) +  (((result[2].split("/")[0].to_i)/(result[2].split("/")[1]).to_f)/3600.0)
      @parking.longitude = longitude_sum

      @parking.save

      redirect_to parking_path(@parking)
    else
      render :new
    end
  end

  def toggle_favorite
    @parking = Parking.find_by(id: params[:id])
    authorize @parking
    current_user.favorited?(@parking) ? current_user.unfavorite(@parking) : current_user.favorite(@parking)
  end

  private

  def parking_params
    params.require(:parking).permit(:name, :description, :photos, :price, :risk_level)
  end
end
