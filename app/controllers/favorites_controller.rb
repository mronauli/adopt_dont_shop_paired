class FavoritesController < ApplicationController

    def update
        pet = Pet.find(params[:id])
        pet_id_str = pet.id.to_s
        session[:favorite] ||= Hash.new(0) 
        session[:favorite][pet_id_str] ||= 0  
        session[:favorite][pet_id_str] = session[:favorite][pet_id_str] + 1
        quantity = session[:favorite][pet_id_str]
        flash[:success] = "#{pet.name} has been added to your favorites"
        redirect_to "/pets/#{pet.id}"
    end
end 