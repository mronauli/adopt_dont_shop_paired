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

        @review_1 = @shelter_1.reviews.create!(title: "Very bad!",
                                  rating: 1.5,
                                  content: "Molly came back skinny")

        @review_2 = @shelter_2.reviews.create!(title: "Splendid!",
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
            save_and_open_page
            expect(page).to have_content(@review_1.title)
            expect(page).to have_content(@review_1.rating)
            expect(page).to have_content(@review_1.content)
            expect(page).to_not have_css("img[src *= '#{@review_1.picture}']")
          end

          expect(page).to_not have_content(@shelter_2.name)
          expect(page).to_not have_content(@review_2.title)
          expect(page).to_not have_content(@review_2.rating)
          expect(page).to_not have_content(@review_2.content)
          expect(page).to_not have_css("img[src *= '#{@review_2.picture}']")
        end
    end
end
