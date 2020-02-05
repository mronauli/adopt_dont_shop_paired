class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(review_params)

    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else 
      flash[:alert] = 'Please enter information for title, rating and content.'
      redirect_to "/shelters/#{@shelter.id}/reviews/new"
    end
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
