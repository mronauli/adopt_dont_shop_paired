class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    favorited_pets = favorite.contents.keys
    @pets = Pet.find(favorited_pets)
  end

  def create
    @applied_for = Pet.find(params[:pets])
    @applied_for.each do |pet|
      pet.applications.new(application_params)
    end
    case @applied_for.map do |pet_app|
      pet_app.save
      end
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
