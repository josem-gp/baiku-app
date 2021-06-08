class User < ApplicationRecord
  acts_as_favoritor

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :parking
  has_many :parkings, through: :user_parkings
  has_many :replies
  has_many :reviews
  validates :name, presence: true
  validates :email, uniqueness: true
end
