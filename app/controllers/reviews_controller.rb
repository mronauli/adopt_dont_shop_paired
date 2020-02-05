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

  def edit
    @shelter_id = params[:id]
    @review = Review.find(params[:id])
  end

  def update
    shelter_id = Review.find(params[:id]).shelter_id
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to "/shelters/#{shelter_id}"
    else
      flash[:alert] = 'Please enter information for title, rating and content.'
      redirect_to "/shelters/#{@review.shelter_id}/reviews/#{@review.id}/edit"
    end
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
