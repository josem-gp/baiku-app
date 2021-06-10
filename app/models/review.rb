class Review < ApplicationRecord
  before_create :check_risk
  after_save :create_notification

  belongs_to :user
  belongs_to :parking
  has_many :replies, dependent: :destroy
  has_one_attached :photo
  validates :comment, presence: true
  validates :risk_level, presence: true
  enum risk_level: [:safe, :risky]

  def check_risk
    @risk_before = parking.average_risk_score
    return @risk_before
  end

  def create_notification
    if check_risk > 40 && parking.average_risk_score <= 40
      parking.favoritors.each do |user|
        notification = Notification.new(message: 0, parking: parking, user_id: user.id)
        notification.save!
      end
    end
  end
end
