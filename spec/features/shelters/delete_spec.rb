require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "When I visit a shelter's show page" do
        before(:each) do 
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)

        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)

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
    end
end
