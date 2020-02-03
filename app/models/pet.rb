class Pet < ApplicationRecord
   validates_presence_of :name, :image, :approximate_age, :sex
   belongs_to :shelter
end