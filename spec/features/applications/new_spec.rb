require "rails_helper"

RSpec.describe "as a visitor" do
  describe "on its favorites show page" do
    before(:each) do
      @shelter_1 = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      @shelter_2 = Shelter.create!(name: "Meg's Shelter", address: "50 Main Street", city: "Hershey", state: "PA", zip: 17033)

      @sparky = @shelter_1.pets.create(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
      @peppo  = @shelter_1.pets.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
      @peter  = @shelter_2.pets.create(name: "Peter", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg", approximate_age: 3, sex: "Male", description: "Sooooo cute!", adoptable: true)

      visit "/pets/#{@sparky.id}"
      click_button "Favorite This Pet"

      visit "/pets/#{@peppo.id}"
      click_button "Favorite This Pet"
    end
    it "can click a link to adopt its favorited pets" do
      visit "/favorites"
      expect(page).to have_content(@sparky.name)
      expect(page).to have_content(@peppo.name)
      click_link "Adopt Favorited Pets"
      expect(current_path).to eq("/applications/new")
    end
    it "can fill out an application to apply for its favorited pets" do

      visit "/favorites"
      click_link "Adopt Favorited Pets"
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content(@sparky.name)
      expect(page).to have_content(@peppo.name)

      name = "Stanley"
      address = "5432 Point Ave"
      city = "Denver"
      state = "CO"
      zip = "80231"
      phone_number = "303-455-9786"
      description = "I have a big backyard"

      select @sparky.name, from: :pets
      select @peppo.name, from: :pets
      #have to hold down command to select multiple. 
      fill_in 'name', with: name
      fill_in 'address', with: address
      fill_in 'city', with: city
      fill_in 'state', with: state
      fill_in 'zip', with: zip
      fill_in 'phone_number', with: phone_number
      fill_in 'description', with: description

      click_on "Submit Application"
      # (Application).allow_any_instance.to receive(@sparky)
      # (Application).allow_any_instance.to receive(@peppo)
      expect(page).to have_content("Application has been submitted successfully!")
      expect(current_path).to eq("/favorites")
      expect(page).to_not have_content(@sparky.name)
      expect(page).to_not have_content(@peppo.name)
    end

    it "will see a flash message if the application is not complete" do
      visit "/favorites"
      click_link "Adopt Favorited Pets"
      expect(current_path).to eq("/applications/new")

      name = ""
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
      expect(page).to have_content("Please enter information for all fields.")
      expect(current_path).to eq("/applications/new")
    end
  end
end
