require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "#pet_names" do
    it "can get names of pets with applications" do
      expect(PetApplication.contents).to eq({'123' => 1, '321' => 1 })

    end
  end
end

describe "pet_find" do
    it "can find pet names" do
      shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: 80202)
      pet_1 = Pet.create(name: 'Peppo', image: 'https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg', approximate_age: 13, sex: 'female', description: "Basically a naked molerat",  adoptable: true, shelter: shelter_1)
      application_1 = Application.create(name: "News Chic", address: "Newspaper", city: "Denver", state: "CO", zip: 80018, phone_number: "909-333-6578", description: "Active", pets: [pet_1])
      expect(application_1.pet_names).to eq(pet_1.name)
    end
  end
