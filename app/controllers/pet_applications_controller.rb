class PetApplicationsController < ApplicationController
  def index
    pet = Pet.find(params[:id])
    @pet_applications = pet.applications
    if @pet_applications.empty?
      flash[:alert] = "There are no applications for this pet yet."
    end
  end

  def pending
    pet = Pet.find(params[:pet_id])
    application = pet.applications.find(params[:application_id])
    pet.update(adoptable: false)
    flash[:alert] = "On hold for #{application.name}"
    redirect_to "/pets/#{pet.id}"
  end
end
