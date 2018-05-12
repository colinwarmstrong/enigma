class Enigma

  def initialize(rotations, offsets)
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

  def create_character_map
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

  def split_message_every_four_characters(message)
    split_message = []
    message_array = message.split('')
    while message_array.length != 0
      split_message << message_array.shift(4)
    end
    return split_message
  end

  def encrypt(message)
    encrypted_array = []
    create_character_map
    shifts = calculating_shifts
    split_message = split_message_every_four_characters(message)

    split_message.each do |four_characters|
      four_characters.each_with_index do |character, index|
        starting_index = @character_map.index(four_characters[index])
        encrypted_index = starting_index + shifts[index]
        encrypted_array << @character_map[encrypted_index]
      end
    end
    return encrypted_array.join("")
  end

  def decrypt(encrypted_message)
    decrypted_array = []
    character_map_reversed = create_character_map.reverse
    shifts = calculating_shifts
    split_message = split_message_every_four_characters(encrypted_message)

    split_message.each do |four_characters|
      four_characters.each_with_index do |character, index|
        starting_index = character_map_reversed.index(four_characters[index])
        decrypted_index = starting_index + shifts[index]
        decrypted_array << character_map_reversed[decrypted_index]
      end
    end
    return decrypted_array.join("")
  end

end