require 'rails_helper'

describe "As a visitor" do
    before(:each) do
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
        @sparko = @shelter_1.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
    end

    describe "When I have added pets to my favorites list and visit favorites index" do
        it "sees all pets I've favorited and its name and image" do
            visit "/pets/#{@sparky.id}"
            click_button "Favorite This Pet"

            visit "/pets/#{@peppo.id}"
            click_button "Favorite This Pet"

            visit "/favorites"
            expect(page).to have_link(@sparky.name)
            expect(page).to have_css("img[src *= 'west_highland_white_terrier_24.jpg']")
            expect(page).to have_link(@peppo.name)
            expect(page).to have_css("img[src *= 'mexican_hairless_105.jp']")
            expect(page).to_not have_content(@sparko.name)
        end
     end
     
     describe "When visit favorites index" do
        it "I can remove pet's from favorites and the are no longer visible within index" do
            visit "/pets/#{@sparky.id}"
            click_button "Favorite This Pet"
            
            visit "/pets/#{@peppo.id}"
            click_button "Favorite This Pet"
            
            visit "/favorites"
            
            within ("#pet-#{@peppo.id}") do 
                expect(page).to have_css("img[src *= 'mexican_hairless_105.jp']")
                expect(page).to have_link(@peppo.name)
                expect(page).to have_button("Unfavorite This Pet")
                click_button "Unfavorite This Pet"
            end 
            
            within ("#pet-#{@sparky.id}") do 
                expect(page).to have_css("img[src *= 'west_highland_white_terrier_24.jpg']")
                expect(page).to have_link(@sparky.name)
                expect(page).to have_button("Unfavorite This Pet")
            end 

            visit "/favorites"
            #discover better way to test refresh page. method does it but cant test it. 
            
            expect(page).to_not have_content(@peppo.name)  
            expect(page).to have_content(@sparky.name)  
        end
    end
    
    describe "When visit favorites index" do
        it "I can remove all pet's from favorites and the are no longer visible within index" do
            visit "/pets/#{@sparky.id}"
            click_button "Favorite This Pet"
            
            visit "/pets/#{@peppo.id}"
            click_button "Favorite This Pet"
            
            visit "/favorites"
            
            expect(page).to have_content(@sparky.name)
            expect(page).to have_content(@peppo.name)
            
            click_button "Unfavorite All Pets"
            
            expect(page).to_not have_content(@sparky.name)
            expect(page).to_not have_content(@peppo.name)
            
            expect(page).to have_content("No pets have been favorited yet")
        end 
    end
    
    describe "after one or more applications have been create" do
        it "sees a section that lists all the pets that have at least one application" do
            visit "/pets/#{@sparky.id}"
            click_button "Favorite This Pet"

            visit "/pets/#{@peppo.id}"
            click_button "Favorite This Pet"

            visit "/favorites"
            click_link "Adopt Favorited Pets"
            expect(current_path).to eq("/applications/new")

            name = "Daniel"
            address = "5432 Point Ave"
            city = "Denver"
            state = "CO"
            zip = "80231"
            phone_number = "303-455-9786"
            description = "I have a big backyard"

            select @sparky.name, from: :pets
            fill_in 'name', with: name
            fill_in 'address', with: address
            fill_in 'city', with: city
            fill_in 'state', with: state
            fill_in 'zip', with: zip
            fill_in 'phone_number', with: phone_number
            fill_in 'description', with: description

            click_on "Submit Application"
        
            visit "/favorites"

            within("#pet_apps") do
                expect(page).to have_content(@sparky.name)
                expect(page).to_not have_content(@peppo.name)
            end
        end
    end
end


