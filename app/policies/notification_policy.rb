class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @notifications = []
      @favorites = user.all_favorited
      @favorites.each do |favorite|
        id = favorite.id
        @notifications << Notification.where(id: id)
      end
      return @notifications
    end
  end
end
