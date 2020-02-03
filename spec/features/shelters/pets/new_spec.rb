require 'rails_helper'
RSpec.describe 'As a visitor' do 
    describe "'When I visit a Shelter Pets Index page" do
        it 'Then I see a link to create a new adoptable pet, "Create Pet" and I am redirected to a new pet form' do 
            shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
            shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)

            visit shelter_pets_path(shelter_1)

            click_link "Create Pet"

            expect(current_path).to eq(new_shelter_pet_path(shelter_1))

            image = 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/rottweiler_7.jpg'
            name  = 'Tank'
            approximate_age = 5
            sex = 'Male'

            fill_in 'pet[image]', with: image 
            fill_in 'pet[name]', with: name 
            fill_in 'pet[approximate_age]',	with: approximate_age
            fill_in 'pet[sex]',	with: sex

            click_on "Create Pet"
            
            expect(current_path).to eq(shelter_pets_path(shelter_1))
            
            expect(page).to have_content(name)
        end
    end
end
