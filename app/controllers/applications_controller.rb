class ApplicationsController < ApplicationController
  def new
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
  end

  def create
    favorited_pets = favorite.keys
    @pet_applications = Pet.find(favorited_pets)
    @pet_applications.each do |pet| 
      pet.applications.new(application_params)
    end
    case @pet_applications.all? { |pet_app| pet_app.save } 
      when true
        session[:favorite].clear
        flash[:success] = "Application has been submitted successfully!" 
        redirect_to "/favorites"
      else 
        flash[:alert] = "Please enter information for all fields."
        redirect_to "/applications/new"
    end 
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
