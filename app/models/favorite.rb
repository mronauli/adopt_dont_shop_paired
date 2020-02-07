class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def delete_pet(id)
    @contents[id.to_s] = count_of(id) - 1
  end

  def keys
    @contents.keys
  end

  def has_pet?(id)
    @contents.keys.include?(id.to_s)
  end
end
