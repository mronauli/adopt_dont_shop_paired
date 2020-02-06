require 'rails_helper'

RSpec.describe Favorite do
  favorite = { Favorite.new({'123' => 1, '321' => 1}) }

  describe "#total_count" do
    it "calculates the total number of songs it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_song" do
    it "adds a song to its contents" do
      cart = Favorite.new({
        '1' => 2,  # two copies of song 1
        '2' => 3   # three copies of song 2
      })
      subject.add_song(1)
      subject.add_song(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end
  end
end