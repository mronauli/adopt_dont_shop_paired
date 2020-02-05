require "rails_helper"

RSpec.describe "on a shelter's show page", type: :feature do
  context "as a visitor" do
    before(:each) do
        @shelter_1 = Shelter.create(name: "Dumb Friends League",
                                    address: "123 Sample St",
                                    city: "Denver",
                                    state: "CO",
                                    zip: 80220)
        @shelter_2 = Shelter.create(name: "Meg's Shelter",
                                    address: "50 Main Street",
                                    city: "Hershey",
                                    state: "PA",
                                    zip: 17033)
        @review_1 = Review.create(title: "Less than okay...",
                                    rating: 9,
                                    content: "Daily naps",
                                    picture: "https://external-preview.redd.it/GjG4tB1Z_A-rdKs5wxx7qR873hJRFl8gTzs7S3d6DJ0.jpg?auto=webp&s=fc48628c7c82e8b87b541ad396a66e7253aa86b9",
                                    shelter: @shelter_1)
        @review_2 = Review.create(title: "Fabulous",
                                    rating: 4,
                                    content: "Walks every three hours",
                                    picture: "https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-001.jpg",
                                    shelter: @shelter_2)
        @review_3 = Review.create(title: "Gross",
                                    rating: 1,
                                    content: "Sadie's hair was matted",
                                    picture: "https://www.gwinnettcounty.com/static/departments/communityservices/images/shelter.jpg",
                                    shelter: @shelter_2)
    end
    it "can see a link to delete a review next to each review" do
      visit "/shelters/#{@shelter_1.id}"
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_css("img[src *= '#{@review_1.picture}']")
      click_link "Delete Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to_not have_content(@review_1.title)
      expect(page).to_not have_content(@review_1.rating)
      expect(page).to_not have_content(@review_1.content)
      expect(page).to_not have_css("img[src *= '#{@review_1.picture}']")
    end
  end
end
