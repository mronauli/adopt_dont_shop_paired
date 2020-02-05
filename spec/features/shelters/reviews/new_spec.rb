require 'rails_helper'

RSpec.describe 'As a visitor' do
    describe "When I visit a shelter's show page" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
      end
        it "I see a like to 'Add Review' and it directs me to a new review form " do

            visit shelter_path(@shelter_1)

            click_link('Add Review')
            expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

            title = "Very bad!"
            rating = 1
            content = "Molly came back skinny"

            fill_in 'title', with: title
            fill_in 'rating', with: rating
            fill_in 'content', with: content

            click_on "Submit Review"

            expect(current_path).to eq("/shelters/#{@shelter_1.id}")

            review_1 = @shelter_1.reviews[0]

            within("#review-#{review_1.id}") do
                expect(page).to have_content(review_1.title)
                expect(page).to have_content(review_1.rating)
                expect(page).to have_content(review_1.content)
            end
        end
    describe "When I fails to enter a title, rating and/or content on the form" do
      it "can see a flash message indicating that I need to fill out title, rating and content in order to submit a shelter review and is returned to form" do
        visit shelter_path(@shelter_1)

        click_link('Add Review')
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

        title = "Very bad!"
        content = "Molly came back skinny"
        rating = ""

        fill_in 'title', with: title
        fill_in 'content', with: content
        fill_in 'rating', with: rating

        click_on "Submit Review"

        expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews")
        expect(page).to have_button("Submit Review")
        expect(page).to have_content "Please enter information for title, rating and content."
      end
    end
  end
end
