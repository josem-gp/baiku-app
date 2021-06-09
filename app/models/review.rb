class Review < ApplicationRecord
  before_save :check_risk
  after_save :create_notification

  belongs_to :user
  belongs_to :parking
  has_many :replies, dependent: :destroy
  has_one_attached :photo
  validates :comment, presence: true
  validates :risk_level, presence: true
  enum risk_level: [:safe, :risky]

  def check_risk
    @average_before = parking.average_risk_score
  end

  def create_notification
    if @average_before >= 40 && parking.average_risk_score < 40
      notification = Notification.new(message: 0, parking_id: parking.id)
      notification.save!
    end
  end
end
