class Pet < ApplicationRecord
   validates_presence_of :name, :image, :approximate_age, :sex, :description

   belongs_to :shelter
   has_many :pet_applications
   has_many :applications, through: :pet_applications
end
