class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def people_names
    PetApplication.joins(:application).map(&:application).map(&:name).uniq
  end
end
