class Pet < ApplicationRecord
   validates_presence_of :name, :image, :approximate_age, :sex, :description
   
   belongs_to :shelter
end