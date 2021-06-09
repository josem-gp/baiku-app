class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.notifications.order(created_at: 'DESC')
    end
  end
end
