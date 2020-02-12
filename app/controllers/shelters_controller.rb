class SheltersController < ApplicationController
  #refractor: add before each action where applicable
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
    @shelter = Shelter.new
  end

  def create
    @shelter = Shelter.create(shelter_params)

    redirect_to shelters_path
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    if @shelter.update_attributes(shelter_params)
      redirect_to shelter_path(@shelter.id)
    else
      flash[:alert] = "Please enter information for all fields."
      redirect_to edit_shelter_path(@shelter.id)
    end
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    if @shelter.pending_pets?
      flash[:alert] = "This shelter cannot be deleted!"
    else
      @shelter.destroy
    end
    redirect_to shelters_path
  end

  private
    def shelter_params
      params.require(:shelter).permit(:name, :address, :city, :state, :zip)
    end
end
