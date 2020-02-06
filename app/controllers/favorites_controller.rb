class FavoritesController < ApplicationController

    def create
        pet = Pet.find(params[:id])
        @favorite = Favorite.new(session[:favorite])
        if @favorite.save
          flash[:success] = "#{pet.name} has been added to your favorites"
          redirect_to "/pets/#{pet.id}"
        else
        #   flash[:error] = "Something went wrong"
        #   render 'new'
        end
    end
    
end 