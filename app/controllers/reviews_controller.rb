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
      render :new
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
      render :edit
    end
  end

  def destroy
    shelter_id = Review.find(params[:id]).shelter_id
    @review = Review.find(params[:id])
    review = Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter_id}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
