class Review < ApplicationRecord
  belongs_to :user
  belongs_to :parking
  has_many :replies, dependent: :destroy
  has_one_attached :photo
  validates :comment, presence: true
  validates :risk_level, presence: true
  enum risk_level: [:safe, :risky]
end
