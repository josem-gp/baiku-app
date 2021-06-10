class NotificationsController < ApplicationController
  def index
    @notifications = policy_scope(Notification)
    @notifications.update_all(read: true)
  end
end
