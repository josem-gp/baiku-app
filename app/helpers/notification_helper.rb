module NotificationHelper
  def format_date(notification)
    notification.created_at.to_date == Date.today ? "Today" : notification.created_at.strftime('%b %d, %Y')
  end
end
