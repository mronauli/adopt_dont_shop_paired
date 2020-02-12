require 'rails_helper'

RSpec.describe 'As a visitor' do
    describe "When I visit a shelter's show page" do
        before(:each) do
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @sparko = @shelter_1.pets.create(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
        @review_1 = Review.create(title: "Less than okay...",
                                    rating: 9,
                                    content: "Daily naps",
                                    picture: "https://external-preview.redd.it/GjG4tB1Z_A-rdKs5wxx7qR873hJRFl8gTzs7S3d6DJ0.jpg?auto=webp&s=fc48628c7c82e8b87b541ad396a66e7253aa86b9",
                                    shelter: @shelter_1)
        end
        it "I can see a link to 'Delete Shelter' " do

            visit shelter_path(@shelter_1)

            expect(page).to have_content(@shelter_1.name)
            expect(page).to have_link("Delete Shelter")

            click_link "Delete Shelter"

            expect(current_path).to eq(shelters_path)
            expect(page).to_not have_content(@shelter_1.name)
            expect(page).to have_content(@shelter_2.name)
        end

        it "I can see a link to 'Delete Shelter' under each shelter in shelters index " do

            visit shelters_path

            within("#shelter-#{@shelter_2.id}") do
                click_link "Delete Shelter"
            end

            expect(page).to_not have_content(@shelter_2.name)
            expect(page).to have_content(@shelter_1.name)
        end

        it "cannot delete a shelter that has pets with pending status" do
          visit "/applications/#{@application_1.id}"
          within ("#pet-#{@sparky.id}") do
            click_link "Approve Application"
          end
          visit shelters_path
          within("#shelter-#{@shelter_1.id}") do
            click_link "Delete Shelter"
          end
          expect(page).to have_content("This shelter cannot be deleted!")
        end

        it "deletes all pets when it deletes the shelter" do
          visit shelter_pets_path(@shelter_1)
          visit pet_path(@sparky)
          expect(page).to have_content(@sparky.name)
          visit shelters_path
          within("#shelter-#{@shelter_1.id}") do
            click_link "Delete Shelter"
          end
          # expect { delete "Delete Shelter", { id: 'unknown' } }.to raise_error(ActiveRecord::RecordNotFound)
        end
        it "deletes a shelter's reviews when it deletes a shelter" do
          visit "/shelters/#{@shelter_1.id}"
          within("#review-#{@review_1.id}") do
            expect(page).to have_content(@review_1.title)
            expect(page).to have_content(@review_1.rating)
            expect(page).to have_content(@review_1.content)
            expect(page).to have_css("img[src *= '#{@review_1.picture}']")
          end
          visit shelters_path
          within("#shelter-#{@shelter_1.id}") do
            click_link "Delete Shelter"
          end
          #show error
        end
    end
end

# [ ] done
#
# User Story 28, Deleting Shelters Deletes its Reviews
#
# As a visitor
# When I delete a shelter
# All reviews associated with that shelter are also deleted
