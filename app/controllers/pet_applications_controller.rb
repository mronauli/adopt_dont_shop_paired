class PetApplicationsController < ApplicationController
  def index
    pet = Pet.find(params[:id])
    @pet_applications = pet.applications
    if @pet_applications.empty?
      flash[:alert] = "There are no applications for this pet yet."
    end
  end
end
