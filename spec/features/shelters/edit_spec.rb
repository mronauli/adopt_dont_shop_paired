require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "'When I visit a shelters show page" do
        before(:each) do
            @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
            @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220) 
        end
        it 'Then I see a link to update the shelter "Update Shelter" and redirected to an edit form' do 

            visit shelter_path(@shelter_1)
            click_link "Update Shelter"
            expect(current_path).to eq(edit_shelter_path(@shelter_1.id))

            name = "DFL Aurora" 
            address = "456 Sample St"
            city = "Aurora"
            state = "CO"
            zip = 80221

            fill_in 'Name',	with: name 
            fill_in "Address",	with: address
            fill_in "City",	with: city
            fill_in "State", with: state
            fill_in "Zip", with: zip
            click_on "Update Shelter"
            
            expect(current_path).to eq(shelter_path(@shelter_1.id))
            
            expect(page).to have_content(name)
            expect(page).to have_content(address)
            expect(page).to have_content(city)
            expect(page).to have_content(state)
            expect(page).to have_content(zip)

            expect(page).to_not have_content(@shelter_1.name)  
            expect(page).to_not have_content(@shelter_1.address)  
        end
        
        it "Then I see a link to update the shelter 'Update shelter' under each shelter's information  and redirected to an edit form" do 
            
            visit shelters_path

            within("#shelter-#{@shelter_1.id}") do
                click_link "Update Shelter"
            end 

            expect(current_path).to eq(edit_shelter_path(@shelter_1.id))
        end
    end
end