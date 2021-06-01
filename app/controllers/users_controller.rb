class UsersController < ApplicationController
  def update
    @user = current_user
    if @user.update(user_params)
    else
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :parking_id)
  end
end
