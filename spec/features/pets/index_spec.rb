require 'rails_helper'

RSpec.describe "As a visitor" do
  context "When I visit '/pets'" do
    before(:each) do 
      @shelter_1 = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      @shelter_2 = Shelter.create!(name: "Meg's Shelter", address: "50 Main Street", city: "Hershey", state: "PA", zip: 17033)
      
      @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male')
      @peppo  = @shelter_2.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female')
    end 
    it "Then I see each Pet in the system including the Pet's attributes" do

    visit pets_path
    expect(current_path).to eq("/pets")

    expect(page).to have_content(@sparky.name)
    expect(page).to have_css("img[src *= 'west_highland_white_terrier_24.jpg']")
    expect(page).to have_content(@sparky.approximate_age)
    expect(page).to have_content(@sparky.sex)
    expect(page).to have_content(@sparky.shelter.name)
    expect(page).to have_content(@peppo.name)
    end
    
    it "I click on the name a pet anywhere on the site, then that link takes me to that Pet's show page" do
        
      visit pets_path 
      
      within("#pet-#{@sparky.id}") do
        click_link(@sparky.name)
       end 

      expect(current_path).to eq(pet_path(@sparky.id))
     end
  end
end

