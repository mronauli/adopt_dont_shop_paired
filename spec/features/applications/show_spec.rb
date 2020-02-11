require "rails_helper"

RSpec.describe "on an application's show page" do
    context "as a visitor" do
      before(:each) do
          @shelter_1 = Shelter.create(name: "Dumb Friends League", address: "123 Sample St", city: "Denver", state: "CO", zip: 80220)
          @sparky = @shelter_1.pets.create(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
          @peppo  = @shelter_1.pets.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
          @sparko = @shelter_1.pets.create(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
          @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
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
  end
end
