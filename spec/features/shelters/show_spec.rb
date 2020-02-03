require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "When I visit '/shelters/:id" do
        it "Then I see the shelter with that id's attributes" do  
            shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)

            visit shelter_path(shelter_1)

            expect(page).to have_link(shelter_1.name)
            expect(page).to have_content(shelter_1.address)
            expect(page).to have_content(shelter_1.city)
            expect(page).to have_content(shelter_1.state)
            expect(page).to have_content(shelter_1.zip)
        end
    end
end