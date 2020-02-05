class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content
  # validates_presence_of :picture, allow_blank: true
  belongs_to :shelter
end
