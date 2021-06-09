class NotificationsController < ApplicationController
  def index
    @notifications = []
    @favorites = current_user.all_favorited
    @favorites.each do |favorite|
      id = favorite.id
      @notifications << Notification.where(id: id)
    end
    return @notifications
    raise
  end
end
