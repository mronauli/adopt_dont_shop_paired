class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
  end

  def update
    pet = Pet.find(params[:id])
    favorite.add_pet(pet.id)
    session[:favorite] ||= favorite.contents
    quantity = favorite.count_of(pet.id)
    flash[:success] = "#{pet.name} has been added to your favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    favorite.delete_pet(pet.id)
    session[:favorite].delete(pet.id.to_s)
    flash[:success] = "#{pet.name} has been removed from your favorites."
    redirect_back(fallback_location: "/pets/#{pet.id}")
  end
end
