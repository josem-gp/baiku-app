class Parking < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, if: :will_save_change_to_latitude?

  has_many :user_parkings
  has_many :users, through: :user_parkings
  has_many :reviews, dependent: :destroy
  has_many_attached :photos
  validates :name, uniqueness: { scope: :address }, presence: true
  # validates :address, presence: true
  # validates :description, length: { minimum: 10 }, presence: true
  enum price: [:free, :paid]
  validates :risk_level, presence: true


  include PgSearch::Model
  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
  using: {
    tsearch: { prefix: true }
  }

  def average_risk_score
    total_reviews = reviews.count
    total_safe = reviews.where(risk_level: 'safe').count
    return (total_safe / total_reviews.to_f * 100).round
  end


  def free_or_paid
    if price == 'free'
      'FREE'
    else
      'Payment required at this spot'
    end
  end

end
