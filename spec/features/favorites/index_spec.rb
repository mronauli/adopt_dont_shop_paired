require 'rails_helper'

describe "As a visitor" do
    before(:each) do 
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
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
     end
end
