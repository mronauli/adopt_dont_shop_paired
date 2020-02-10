require 'rails_helper'

describe "on the pet applications index page" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
    @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
    @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
    @sparko = @shelter_1.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
    @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
    @application_2 = @sparky.applications.create(name: "Butter", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
  end
  describe "after one or more applications have been create" do
    it "sees a section that lists all the pets that have at least one application" do
      visit "/pets/#{@sparky.id}"
      click_link "View All Applications for this Pet"

      visit "/pet_applications/#{@sparky.id}"
      expect(page).to have_link(@application_1.name)
      expect(page).to have_link(@application_2.name)
    end
  end
end

# User Story 20, Pet Applications Index Page
#
# As a visitor
# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicant's name is a link to their application show page
