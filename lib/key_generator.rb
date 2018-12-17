class KeyGenerator
  def generate_key
    key = []
    5.times do
      key << rand(1..9)
    end
    key.join('')
  end
end
