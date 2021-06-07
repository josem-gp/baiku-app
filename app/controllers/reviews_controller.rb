class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @parking = Parking.find(params[:parking_id])
    @review.parking = @parking
    authorize @review
    if @review.save
      redirect_to parking_path(@parking)
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :risk_level, :photo)
  end
end
