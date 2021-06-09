class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @notifications = []
      @parking_ids = []
      @all = Notification.all.order(created_at: 'DESC')
      @favorites = user.all_favorited
      @favorites.each do |favorite|
        @parking_ids << favorite.id
      end
      @parking_ids

      @all.each do |notification|
        if @parking_ids.include?(notification.parking_id)
          @notifications << notification
        end
      end
      @notifications
    end
  end
end
