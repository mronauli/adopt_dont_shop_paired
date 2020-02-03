require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "'When I visit '/shelters'" do
        before(:each) do
            @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
            @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)    
        end
        it 'then I see the name of each shelter in the system' do 

            visit shelters_path
            expect(current_path).to eq("/shelters")

            expect(page).to have_content(@shelter_1.name)
            expect(page).to have_content(@shelter_2.name)
        end
        it "I click on the name a shelter anywhere on the site, then that link takes me to that Shelter's show page" do

            visit shelters_path 
            
            within("#shelter-#{@shelter_1.id}") do
              click_link(@shelter_1.name)
             end 
      
            expect(current_path).to eq(shelter_path(@shelter_1.id))
        end
    end
end