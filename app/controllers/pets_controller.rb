class PetsController < ApplicationController

    def index
      if params[:shelter_id]
          @shelter = Shelter.find(params[:shelter_id])
          @pets = @shelter.pets
      else
          @pets = Pet.all
      end
    end

    def show
        @pet = Pet.find(params[:id])
    end

    def new
        @shelter = Shelter.find(params[:shelter_id])
        @pet = @shelter.pets.new
    end

    def create

        @shelter = Shelter.find(params[:shelter_id])
        @pet = @shelter.pets.create(pet_params)

        redirect_to shelter_pets_path
    end

    def edit
        @pet = Pet.find(params[:id])
    end

    def update
        @pet = Pet.find(params[:id])
        if @pet.update_attributes(pet_params)
          redirect_to pet_path
        else
          flash[:alert] = "Please enter information for all fields."
          redirect_to "/pets/#{@pet.id}/edit"
        end
     end

    def destroy
        pet = Pet.find(params[:id])
        favorite.contents.delete(pet.id.to_s)
        pet.destroy
        redirect_to pets_path
    end

    private
        def pet_params
            params.require(:pet).permit(:image, :name, :approximate_age, :sex, :description)
        end
end
