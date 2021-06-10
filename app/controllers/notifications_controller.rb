class NotificationsController < ApplicationController
  def index
    @notifications = policy_scope(Notification)
    @notifications.update_all(read: true)

    @notifications.each do |notification|
      today_date = (Date.today).strftime('%b %dth, %Y')
      creation_date = (notification.created_at).strftime('%b %dth, %Y')
      if today_date == creation_date
        @date = 'Today'
      else
        @date = creation_date
      end
    end
    @date
  end
end
