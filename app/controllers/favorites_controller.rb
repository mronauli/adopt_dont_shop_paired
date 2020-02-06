class FavoritesController < ApplicationController

    def update
        pet = Pet.find(params[:id])
        favorite.add_pet(pet.id)
        session[:favorite] ||= favorite.contents
        quantity = favorite.count_of(pet.id)
        flash[:success] = "#{pet.name} has been added to your favorites"
        redirect_to "/pets/#{pet.id}"
    end
end 