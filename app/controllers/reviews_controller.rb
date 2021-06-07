class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.parking = Parking.find(params[:parking_id])
    authorize @review
    if @review.save
      redirect_to parking_path(:parking_id)
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :risk_level)
  end
  
  
end
