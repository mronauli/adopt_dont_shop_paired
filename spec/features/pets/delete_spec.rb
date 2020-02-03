require 'rails_helper'

RSpec.describe 'As a visitor' do 
    describe "When I visit a Pet's show page" do
        before(:each) do 
            @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
            @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)
            
            @pet_1 = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male')
            @pet_2  = @shelter_2.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female')
            @pet_3 = @shelter_2.pets.create!(name: "Peter", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg", approximate_age: 3, sex: "Male", adoptable: true)
        end

        it "I can see a link to 'Delete Pet' " do  

            visit pet_path(@pet_1)

            expect(page).to have_content(@pet_1.name)
           
            click_link "Delete Pet"

            expect(current_path).to eq(pets_path) 
            expect(page).to_not have_content(@pet_1.name)
            expect(page).to have_content(@pet_2.name)   
        end
        it "Then I see a link to update the pet 'Delete Pet' under each pet's information  and it deletes it" do 
            
            visit pets_path

            within("#pet-#{@pet_1.id}") do
                click_link "Delete Pet"
            end 

            expect(page).to_not have_content(@pet_1.name)

            expect(page).to have_content(@pet_2.name)   
            expect(page).to have_content(@pet_3.name)   
        end
    end
end
