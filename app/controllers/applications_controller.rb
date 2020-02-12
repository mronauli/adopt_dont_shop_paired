class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
  end

  def create
    @applications = []
    application = Application.new(application_params)
    pets = params[:pets]
    pets.each do |id|
      pet = Pet.find(id)
      application.pets << pet
    end
    if application.save
       @applications << application
       pets.each do |id|
         session[:favorite].delete(id)
      end
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
