class Notification < ApplicationRecord
  belongs_to :parking
  validates :message, presence: true
  enum message: [:risk, :new_parking]
end
