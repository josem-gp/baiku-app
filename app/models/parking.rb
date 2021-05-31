class Parking < ApplicationRecord
  belongs_to :user
  has_many :user_parkings
  has_many :users, through: :user_parkings
  has_many :reviews
  validates :name, uniqueness: { scope: :address }, presence: true
  validates :address, presence: true
  validates :description, length: { minimum: 10 }, presence: true
  enum price: [:free, :paid]
end
