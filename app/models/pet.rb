class Pet < ApplicationRecord
   validates_presence_of :name, :image, :approximate_age, :sex, :description
   # look for defaulting image
   belongs_to :shelter
end