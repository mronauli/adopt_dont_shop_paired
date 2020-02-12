class PetApplicationsController < ApplicationController
  def index
    pet = Pet.find(params[:id])
    @pet_applications = pet.applications
    if @pet_applications.empty?
      flash[:alert] = "There are no applications for this pet yet."
    end
  end

  def approved
    approved_application = PetApplication.find_by(pet_id: params[:pet_id])
    if approved_application.approved == true
      pet = approved_application.pet
      pet.update(adoptable: false)
      flash[:alert] = "No more applications for this pet can be approved at this time."
    else
      pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:application_id])
      pet_application.update(approved: true)
      pet_application.save
      pet = Pet.find(params[:pet_id])
      pet.update(adoptable: false)
      flash[:alert] = "On hold for #{pet_application.application.name}"
    end
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def revoked
    pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:application_id])
    pet_application.update(approved: false)
    pet_application.save
    pet = Pet.find(params[:pet_id])
    pet.update(adoptable: true)
    redirect_to "/applications/#{pet_application.application.id}"
  end
end
