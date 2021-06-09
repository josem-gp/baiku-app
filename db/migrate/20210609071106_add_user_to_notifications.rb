class AddUserToNotifications < ActiveRecord::Migration[6.0]
  def change
    Notification.destroy_all
    add_reference :notifications, :user, null: false, foreign_key: true
    add_column :notifications, :read, :boolean, default: false
  end
end
