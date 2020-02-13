require 'rails_helper'

RSpec.describe 'As a visitor' do
    describe "When I visit a Pet's show page" do
        before(:each) do
            @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
            @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)
            @pet_1 = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male',description: "Fun but no so nice", adoptable: true )
            @pet_2  = @shelter_2.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat", adoptable: true)
            @pet_3 = @shelter_2.pets.create!(name: "Peter", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg", approximate_age: 3, sex: "Male", description: "Sooooo cute!", adoptable: true)
            @application_1 = Application.create(name: "Jerry", address: "5678 Argon St", city: "Chillen", state: "PA", zip: 43569, phone_number: "303-376-0193", description: "Lots of snacks", pets:[@pet_2])
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
        it "can not delete a pet that has approved applications" do
          visit "/applications/#{@application_1.id}"
          within ("#pet-#{@pet_2.id}") do
            click_link "Approve Application"
          end
          visit pets_path
          within("#pet-#{@pet_1.id}") do
              expect(page).to have_link("Delete Pet")
          end
          visit pets_path
          within("#pet-#{@pet_2.id}") do
              expect(page).to_not have_link("Delete Pet")
          end
        end
        it "removes a pet from favorites when it deletes a pet" do

          visit "/pets/#{@pet_1.id}"
          click_button "Favorite This Pet"

          visit "/pets/#{@pet_2.id}"
          click_button "Favorite This Pet"

          within ".navbar-nav" do
            expect(page).to have_content("Favorites: 2")
          end
          visit "/pets/#{@pet_1.id}"


          click_link "Delete Pet"

          visit pets_path

          within ".navbar-nav" do
            expect(page).to have_content("Favorites: 1")
          end

          within("#pet-#{@pet_1.id}") do
            click_link "Delete Pet"
          end

          within ".navbar-nav" do
            expect(page).to have_content("Favorites: 0")
          end
        end
    end
end



# User Story 32, Deleting a pet removes it from favorites
#
# As a visitor
# If I've added a pet to my favorites
# When I try to delete that pet from the database
# They are also removed from the favorites list
