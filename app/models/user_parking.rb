class UserParking < ApplicationRecord
  belongs_to :user
  belongs_to :parking
  validates :date, presence: true
end
