class ApplicationsController < ApplicationController
  def new
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
  end

  def create
    application = Application.create(application_params)
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
    #application is for all pets not an individual pet.
    if application.save
      @pets.each {|pet| pet.applications << application}
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
