require 'rails_helper'

RSpec.describe " As a visitor" do
    before(:each) do
        @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
    end

    it "can favorite a pet" do
        visit "/pets/#{@sparky.id}"

        click_button "Favorite This Pet"

        expect(current_path).to eq("/pets/#{@sparky.id}")

        expect(page).to have_content "#{@sparky.name} has been added to your favorites"
    end

    it "displays the total number of pets in the favorites" do
        visit "/pets/#{@sparky.id}"

        expect(page).to have_content("Favorites: 0")

        click_button "Favorite This Pet"

        expect(page).to have_content("Favorites: 1")

        visit "/pets/#{@peppo.id}"

        click_button "Favorite This Pet"

        expect(page).to have_content("Favorites: 2")
    end

    it "can't favorite a pet more than once" do
      visit "/pets/#{@sparky.id}"

      click_button "Favorite This Pet"

      expect(page).to_not have_button("Favorite This Pet")
      expect(page).to have_button("Unfavorite This Pet")
    end

    it "can remove pet from favorites" do
      visit "/pets/#{@sparky.id}"

      click_button "Favorite This Pet"
      click_button "Unfavorite This Pet"

      expect(current_path).to eq("/pets/#{@sparky.id}")
      expect(page).to have_content("#{@sparky.name} has been removed from your favorites.")

      # expect(page).to have_button("Favorite This Pet")
      # expect(page).to_not have_button("Unfavorite This Pet")

      expect(page).to have_content("Favorites: 0")

    end
end
