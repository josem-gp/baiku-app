class Parking < ApplicationRecord
  include PgSearch::Model
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :user_parkings
  has_many :users, through: :user_parkings
  has_many :reviews, dependent: :destroy
  has_many_attached :photos

  pg_search_scope :search_by_name_and_address,
    against: [ :name, :address ],
  using: {
    tsearch: { any_word: true }
  }

  validates :name, uniqueness: { scope: :address }, presence: true
  validates :address, presence: true
  validates :description, length: { minimum: 10 }, presence: true
  enum price: [:free, :paid]
end
