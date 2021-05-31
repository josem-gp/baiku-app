class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :comment, presence: true
end
