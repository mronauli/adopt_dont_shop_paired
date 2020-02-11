class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def has_pet?(pet_id)
    self.pets.include(pet_id) 
  end
end
