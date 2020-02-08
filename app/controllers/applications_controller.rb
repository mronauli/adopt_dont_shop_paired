class ApplicationsController < ApplicationController
  def new
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
  end

  def create
    application = Application.create(application_params)
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
    @pets << application
    flash[:success] = "Application for #{@pets.names} submitted successfully!"
    redirect_to "/favorites"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
