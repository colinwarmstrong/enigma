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

  def creates_character_map
    single_character_map = []
    ("a".."z").each do |lowercase_letter|
      single_character_map << lowercase_letter
    end
    ("A".."Z").each do |uppercase_letter|
      single_character_map << uppercase_letter
    end
    ("0".."9").each do |number|
      single_character_map << number
    end
    single_character_map << [' ', '!', '@', '#', '$', '%', '^', '&']
    single_character_map << ['*', '(', ')', '[', ']', ',', '.', '<']
    single_character_map << ['>', ';', ':', '/', '?', "\\", '|' ]
    single_character_map.flatten!
    3.times do
      @character_map << single_character_map
    end
    @character_map.flatten!
    # revisit maybe use rotate method on array
  end

  def split_message_every_4_characters
    split_message = []
    message_array = @message.split('')
    while message_array.length != 0
      split_message << message_array.shift(4)
    end
    return split_message
  end

end
