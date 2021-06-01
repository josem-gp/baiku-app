class UsersController < ApplicationController
  before_action :authorize_user

  def edit
    @parking = Parking.find(35)
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:parking_id)
  end

  def authorize_user
    authorize @user = current_user
  end
end
