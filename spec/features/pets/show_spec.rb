require 'rails_helper'

RSpec.describe 'As a visitor' do
    before(:each) do
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @shelter_2 = Shelter.create!(name: "Smart Friends League", address: "456 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: false)
        @spark = @shelter_2.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
        @application_2 = @peppo.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
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

            expect(page).to have_content("Adoptable")
            expect(@sparky.adoptable).to eq(true)


            expect(@peppo.adoptable).to eq(false)
        end

        it "I click on the name a pet anywhere on the site, then that link takes me to that Pet's show page" do

            visit pet_path(@sparky)

            click_link(@sparky.name)

            expect(current_path).to eq(pet_path(@sparky.id))
        end

        it "can click the name of a pet and take it to that pet's show page" do
          visit "/pets"
          expect(page).to have_link "#{@peppo.name}"
          expect(page).to have_link "#{@sparky.name}"
          expect(page).to have_link "#{@spark.name}"

          visit "/applications/#{@application_1.id}"
          within("#pet-#{@sparky.id}") do
            expect(page).to have_link "#{@sparky.name}"
          end
          visit "/applications/#{@application_2.id}"
          within("#pet-#{@peppo.id}") do
            expect(page).to have_link "#{@peppo.name}"
          end
          visit "/pets/#{@peppo.id}"
          click_button "Favorite This Pet"

          visit "/favorites"
          expect(page).to have_link "#{@peppo.name}"
        end
    end
end
