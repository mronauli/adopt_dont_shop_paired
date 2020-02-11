require "rails_helper"

RSpec.describe "on an application's show page" do
    context "as a visitor" do
      before(:each) do
          @shelter_1 = Shelter.create(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
          @sparky = @shelter_1.pets.create(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
          @peppo  = @shelter_1.pets.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
          @sparko = @shelter_1.pets.create(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
          @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
          @application_2 = Application.create(name: "Dom", address: "5460 Consuelo St", city: "Boston", state: "MA", zip: 56789, phone_number: "403-267-9810", description: "Lots of attention to give", pets:[@peppo, @sparko])
      end

      it "can see an application and its information" do

        visit "/applications/#{@application_1.id}"
        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zip)
        expect(page).to have_content(@application_1.phone_number)
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@sparky.name)
        expect(page).to_not have_content(@peppo.name)
    end
    it "can click a link to to approve an application for a specific pet" do
      visit "/applications/#{@application_1.id}"
      within ("#pet-#{@sparky.id}") do
        click_link "Approve Application"
        expect(current_path).to eq("/pets/#{@sparky.id}")
      end
    end
    it "it can see that the pet's status has changed to 'pending' on the pet's show page" do
      visit "/applications/#{@application_1.id}"
      click_link "Approve Application"
      expect(current_path).to eq("/pets/#{@sparky.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("On hold for #{@application_1.name}")
    end
    it "can get approved to adopt more than one pet" do
        visit "/applications/#{@application_2.id}"
        within ("#pet-#{@peppo.id}") do
          click_link "Approve Application"
          expect(current_path).to eq("/pets/#{@peppo.id}")
      end
      visit "/applications/#{@application_2.id}"
      within ("#pet-#{@sparko.id}") do
        click_link "Approve Application"
        expect(current_path).to eq("/pets/#{@sparko.id}")
      end
    end
  end

  it "cannot approve an application if an application has already been approved for the pet" do
  end
end

# User Story 24, Pets can only have one approved application on them at any time
#
# [ ] done
#
# As a visitor
# When a pet has more than one application made for them
# And one application has already been approved for them
# I can not approve any other applications for that pet but all other applications still remain on file (they can be seen on the pets application index page)
# (This can be done by either taking away the option to approve the application, or having a flash message pop up saying that no more applications can be approved for this pet at this time)
