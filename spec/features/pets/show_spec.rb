require 'rails_helper'

RSpec.describe 'As a visitor' do
    before(:each) do 
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
    
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', adoptable: false)

    end

    describe "When I visit '/pets/:id'" do
        it "Then I see the pet with that pet's attributes" do  
    
            visit pet_path(@sparky)

            expect(page).to have_content(@sparky.name) 
            expect(page).to have_css("img[src *= '#{@sparky.image}']")
            expect(page).to have_content(@sparky.approximate_age)
            expect(page).to have_content(@sparky.sex)
            expect(page).to have_link(@sparky.shelter.name)

            expect(page).to_not have_content(@peppo.name) 
        end
    end
    
    describe "When I visit '/pets/:id'" do
        it "I see the adoption status" do
            visit pet_path(@sparky)

            expect(page).to have_content(@sparky.adoptable)

            expect(@sparky.adoptable).to eq(true)  
            expect(@peppo.adoptable).to eq(false)  
        end 

        it "I click on the name a pet anywhere on the site, then that link takes me to that Pet's show page" do
        
            visit pet_path(@sparky)

            click_link(@sparky.name)

            expect(current_path).to eq(pet_path(@sparky.id))
        end
    end
end
