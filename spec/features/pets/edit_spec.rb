require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "'When I visit a pet's show page" do
        before(:each) do 
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female')
        end 

        it 'Then I see a link to update the pet "Update Pet" and redirected to an edit form' do 

            visit pet_path(@sparky)
            click_link "Update Pet"
            expect(current_path).to eq(edit_pet_path(@sparky.id))

            name = "twinkle" 
            image = "https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg"
            approximate_age = "1"
            sex = "female"
            zip = 80221

            fill_in 'pet[image]', with: image 
            fill_in 'pet[name]', with: name 
            fill_in 'pet[approximate_age]',	with: approximate_age
            fill_in 'pet[sex]',	with: sex
            click_on "Update Pet"

            expect(current_path).to eq(pet_path(@sparky.id))
            
            expect(page).to have_css("img[src *= '#{@sparky.image}']")
            expect(page).to have_content(name)
            expect(page).to have_content(approximate_age)
            expect(page).to have_content(sex)

            expect(page).to_not have_content(@sparky.name)  
            expect(page).to_not have_content(@sparky.approximate_age)  
        end
    
        it "Then I see a link to update the pet 'Update Pet' under each pet's information  and redirected to an edit form" do 
            
            visit pets_path

            within("#pet-#{@sparky.id}") do
                click_link "Update Pet"
            end  
            expect(current_path).to eq(edit_pet_path(@sparky.id))
        end
    end
end