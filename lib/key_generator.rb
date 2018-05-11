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
  end

end
