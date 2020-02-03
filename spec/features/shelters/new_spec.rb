require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "'When I visit '/shelters'" do
        it 'Then I see a link to create a new Shelter, "New Shelter" and I am redirected to a new shelter form' do 
            shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
            shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)

            visit shelters_path
            click_link "Create New Shelter"
            expect(current_path).to eq(new_shelter_path)

            name = "DFL" 
            address = "456 Sample St"
            city = "Denver"
            state = "CO"
            zip = 80220

            fill_in 'Name',	with: name 
            fill_in "Address",	with: address
            fill_in "City",	with: city
            fill_in "State", with: state
            fill_in "Zip", with: zip
            click_on "Create Shelter"
            
            expect(current_path).to eq(shelters_path)
            
            expect(page).to have_content(name)
        end
    end
end