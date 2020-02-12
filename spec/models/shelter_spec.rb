require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
      it { should have_many :pets }
  end

  describe "approved pets" do
    it "can check if there are any approved pets in shelter" do
      shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      pet_1 = Pet.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat", adoptable: false, shelter: shelter_1)
      expect(shelter_1.pending_pets?).to eq(true)
    end
  end

  describe "pet_count" do
    it "can count number of pets at a shelter" do
      shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      pet_1 = Pet.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat", adoptable: false, shelter: shelter_1)
      expect(shelter_1.pet_count).to eq(1)
    end
  end

  describe "average_rating" do
    it "can count the average shelter review rating" do
      shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      shelter_2 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      review_1 = Review.create(title: "Less than okay...",
                                  rating: 2,
                                  content: "Daily naps",
                                  picture: "https://external-preview.redd.it/GjG4tB1Z_A-rdKs5wxx7qR873hJRFl8gTzs7S3d6DJ0.jpg?auto=webp&s=fc48628c7c82e8b87b541ad396a66e7253aa86b9",
                                  shelter: shelter_1)
      review_2 = Review.create(title: "Fabulous",
                                  rating: 4,
                                  content: "Walks every three hours",
                                  picture: "https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-001.jpg",
                                  shelter: shelter_1)
      review_3 = Review.create(title: "Gross",
                                  rating: 3,
                                  content: "Sadie's hair was matted",
                                  picture: "https://www.gwinnettcounty.com/static/departments/communityservices/images/shelter.jpg",
                                  shelter: shelter_2)
      expect(shelter_1.average_rating).to eq(3)
    end

    describe "count_applications" do
      it "can count the number of applications on file for a shelter" do
        shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
        shelter_2 = Shelter.create(name: "Megs's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
        sparky = shelter_1.pets.create!(name: 'Sparky', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        peppo  = shelter_1.pets.create!(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true)
        sparko = shelter_1.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        spark = shelter_2.pets.create!(name: 'Sparko', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/west_highland_white_terrier_24.jpg', approximate_age: 5, sex: 'male', description: "Fun but no so nice",  adoptable: true)
        application_1 = sparky.applications.create(name: "Betty", address: "1234 Crocker St", city: "Rialto", state: "CO", zip: 80432, phone_number: "404-231-9056", description: "Loves dogs")
        application_2 = sparky.applications.create(name: "Butter", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
        application_3 = peppo.applications.create(name: "Boop", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
        application_4 = spark.applications.create(name: "Bonny", address: "1234 Cup St", city: "Sillicon Valley", state: "CO", zip: 80532, phone_number: "403-231-9056", description: "Loves doge")
        expect(shelter_1.count_applications).to eq(3)
      end
    end
  end
end
