require 'rails_helper'

RSpec.describe 'As a visitor' do
    describe "When I visit '/shelters/:id" do
      before(:each) do
        @shelter_1 = Shelter.create(name: "Mike's Shelter",
                                   address: "1331 17th Street",
                                   city: "Denver",
                                   state: "CO",
                                   zip: 80202)

        @shelter_2 = Shelter.create(name: "Meg's Shelter",
                                    address: "50 Main Street",
                                    city: "Hershey",
                                    state: "PA",
                                    zip: 17033)
        @sparky = @shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @peppo  = @shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
        @sparko = @shelter_1.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @spark = @shelter_2.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        @application_1 = @sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
        @application_2 = @sparky.applications.create(name: "Butter", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
        @application_3 = @peppo.applications.create(name: "Boop", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
        @application_4 = @spark.applications.create(name: "Bonny", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
        @review_1 = @shelter_1.reviews.create!(title: "Very bad!",
                                  rating: 1,
                                  content: "Molly came back skinny")
        @review_2 = @shelter_1.reviews.create!(title: "Very okay!",
                                               rating: 3,
                                               content: "Daily massage")

        @review_3 = @shelter_2.reviews.create!(title: "Splendid!",
                                  rating: 4,
                                  content: "It's like a hotel but for pets",
                                  picture: "https://www.google.com/search?q=dumb+friends+league&tbm=isch&ved=2ahUKEwjwiKP13bbnAhX4AJ0JHfaFBi0Q2-cCegQIABAA&oq=dumb+friends+league&gs_l=img.3..0l6j0i5i30l3j0i24.14422.18052..18299...1.0..0.58.969.20......0....1..gws-wiz-img.......35i39j0i67j0i131j0i30j0i8i30.MQn0aSRcWtk&ei=Rcc4XrDSMPiB9PwP9oua6AI&bih=723&biw=1499&rlz=1C5CHFA_enUS872US872#imgrc=BfA_oIgFjbI-5M")
      end

        it "Then I see the shelter with that id's attributes" do

            visit shelter_path(@shelter_1)

            expect(page).to have_link(@shelter_1.name)
            expect(page).to have_content(@shelter_1.address)
            expect(page).to have_content(@shelter_1.city)
            expect(page).to have_content(@shelter_1.state)
            expect(page).to have_content(@shelter_1.zip)
        end
        it "can see a list of reviews for that shelter; each review has title, rating, content and optional picture" do
            visit shelter_path (@shelter_1)

            expect(page).to have_content(@shelter_1.name)

            within("#review-#{@review_1.id}") do

            expect(page).to have_content(@review_1.title)
            expect(page).to have_content(@review_1.rating)
            expect(page).to have_content(@review_1.content)
            expect(page).to_not have_css("img[src *= '#{@review_1.picture}']")
          end

            expect(page).to_not have_content(@shelter_2.name)
            expect(page).to_not have_content(@review_3.title)
            expect(page).to_not have_content(@review_3.rating)
            expect(page).to_not have_content(@review_3.content)
            expect(page).to_not have_css("img[src *= '#{@review_3.picture}']")
        end
        it "can see count of pets, review and number of applications at a shelter" do
          visit shelter_path (@shelter_1)
          within("#pet_count-#{@shelter_1.id}") do
            expect(page).to have_content("3")
          end
          within("#rating-#{@shelter_1.id}") do
            expect(page).to have_content("2")
          end
          within("#num_apps-#{@shelter_1.id}") do
            expect(page).to have_content("3")
          end
        end
        it "can click link for all shelter names" do
          visit "/shelters/#{@shelter_1.id}"
          expect(page).to have_link "#{@shelter_1.name}"

          visit "/pets/"
          within("#pet-#{@sparky.id}") do
            expect(page).to have_link "#{@shelter_1.name}"
          end
          within("#pet-#{@spark.id}") do
            expect(page).to have_link "#{@shelter_2.name}"
          end
          visit "/pets/#{@sparky.id}"
          expect(page).to have_link "#{@shelter_1.name}"

          visit "/pets/#{@peppo.id}"
          expect(page).to have_link "#{@shelter_1.name}"

          visit "/pets/#{@sparko.id}"
          expect(page).to have_link "#{@shelter_1.name}"

          visit "/pets/#{@spark.id}"
          expect(page).to have_link "#{@shelter_2.name}"

          visit "/favorites"
          expect(page).to have_link "#{@peppo.name}"

          visit "/shelters"
          within("#shelter-#{@shelter_1.id}") do
            expect(page).to have_link "#{@shelter_1.name}"
          end
          within("#shelter-#{@shelter_2.id}") do
            expect(page).to have_link "#{@shelter_2.name}"
          end
        end
    end
end
