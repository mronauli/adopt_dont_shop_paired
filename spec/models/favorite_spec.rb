require 'rails_helper'

RSpec.describe Favorite do
    
    describe "#total_count" do
        subject { Favorite.new({'123' => 1, '321' => 1}) }
        it "calculates the total number of pets it holds" do
            expect(subject.total_count).to eq(2)
        end
    end

    describe "#add_pet" do
        subject { Favorite.new({}) }
        it "adds a pet to its contents" do
            favorite = Favorite.new({
            '123' => 1,  # 1 copies of pet 1
            '321' => 1   # 1 copies of pet 2
            })
            subject.add_pet(123)
            subject.add_pet(321)

            expect(subject.contents).to eq({'123' => 1, '321' => 1 })
        end
    end

    describe "#count_of" do
        it "returns the count of all pets in the favorite" do
          favorite = Favorite.new({})
      
          expect(favorite.count_of(2)).to eq(0)
        end
      end
    
    describe "#keys" do #save_and_open coverage isnt hitting this line
        subject { Favorite.new({'123' => 1, '321' => 1}) }
        it "returns the keys of all pets in the favorite" do
           expect(subject.contents.keys).to eq(['123', '321'])
        end
    end
end