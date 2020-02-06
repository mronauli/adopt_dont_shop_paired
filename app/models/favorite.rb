class Favorite 
    attr_reader :content

    def initialize(initial_contents)
      @content = initial_contents || Hash.new(0)
    end

    def count_of(id)
      @contents[id.to_s].to_i
    end
end 