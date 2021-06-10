class Notification < ApplicationRecord
  belongs_to :parking
  belongs_to :user
  validates :parking_id, presence: true
  validates :message, presence: true
  enum message: [:risk, :new_parking]
end
