require 'rails_helper'

RSpec.describe " As a visitor" do
    before(:each) do 
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
    end
    it "can favorite a pet" do 
        visit "/pets/#{@sparky.id}"

        click_button "Favorite This Pet"

        expect(current_path).to eq("/pets/#{@sparky.id}")  

        expect(page).to have_content "#{@sparky.name} has been added to your favorites"

        #may need a within something
        # expect(favorite.counter).to change {favorite.counter} by(1)
    end 
end
