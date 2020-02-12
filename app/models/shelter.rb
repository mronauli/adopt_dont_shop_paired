class Shelter < ApplicationRecord
   validates_presence_of :name, :address, :city, :state, :zip
   has_many :pets, dependent: :destroy
   has_many :reviews, dependent: :destroy

   def pending_pets?
     pets.exists?(adoptable: false)
   end

   def pet_count
     pets.count
   end

   def average_rating
     Review.average(:rating).present? ? Review.average(:rating) : 0
   end

   def count_applications
     Pet.joins(:applications).distinct(:shelter).count
   end
end
