class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def people_names
    application.name
  end
end
