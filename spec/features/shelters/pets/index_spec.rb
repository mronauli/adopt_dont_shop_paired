require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit '/shelters/:shelter_id/pets'" do
    before(:each) do 
      @shelter_1 = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      @shelter_2 = Shelter.create!(name: "Meg's Shelter", address: "50 Main Street", city: "Hershey", state: "PA", zip: 17033)
  
      @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male')
      @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female')
      @peter  = @shelter_2.pets.create!(name: "Peter", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg", approximate_age: 3, sex: "Male")
    end
    it "Then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's attributes" do
        visit shelter_pets_path(@shelter_1)

        expect(current_path).to eq(shelter_pets_path(@shelter_1))
        expect(page).to have_content("#{@shelter_1.name}'s Pets") 

        expect(page).to have_content(@sparky.name) 
        expect(page).to have_content(@sparky.name)
        expect(page).to have_css("img[src *= '#{@sparky.image}']")
        expect(page).to have_content(@sparky.approximate_age)
        expect(page).to have_content(@sparky.sex)
        expect(page).to have_link(@sparky.shelter.name)
        expect(page).to have_content(@peppo.name) 

        expect(page).to_not have_content(@peter.name)        
    end 
  end 
end 