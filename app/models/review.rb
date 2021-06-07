class Review < ApplicationRecord
  belongs_to :user
  belongs_to :parking
  has_many :replies, dependent: :destroy
  has_one_attached :photo
  validates :comment, presence: true
  # validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :risk_level, presence: true
  enum risk_level: [:safe, :risky]
end
