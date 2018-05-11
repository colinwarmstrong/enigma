class KeyGenerator
  attr_reader :key_length

  def initialize
    @key_length = 5
  end

  def generate_random_number
    key = []
    @key_length.times do
      key << rand(1..9)
    end
    return key
    # is this truly random ?
  end

  def define_rotations(key)
    rotations = []
    key.each_with_index do |digit, index|
      rotation = key[index..index + 1].join.to_i
      rotations << rotation
    end
    rotations.pop
    return rotations
  end

end
