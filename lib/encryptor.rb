class Encryptor

  def initialize(message, rotations, offsets)
    @message = message
    @rotations = rotations
    @offsets = offsets
    @character_map = []
  end

  def calculating_shifts
    shifts = []
    @rotations.each_with_index do |number, index|
      shifts << number + @offsets[index]
    end
    return shifts
  end



end
