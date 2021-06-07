class UsersController < ApplicationController
  before_action :authorize_user

  def update
    if @user.update(user_params)
      redirect_to parkings_path
    end
    @parking = Parking.new
  end

  private

  def user_params
    params.require(:user).permit(:parking_id)
  end

  def authorize_user
    authorize @user = current_user
  end
end
