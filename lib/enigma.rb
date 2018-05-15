require './lib/key_generator'
require './lib/offsets_calculator'
require 'date'
require 'pry'

class Enigma
  attr_reader :key

  def initialize(key = KeyGenerator.new.generate_key, date = Date.today)
    @key = key.chars
    @date = date
    @rotations = define_rotations
    @offsets = OffsetsCalculator.new.define_offsets
    @character_map = []
  end

  def define_rotations
    rotations = []
    @key.each_with_index do |digit, index|
      rotation = @key[index..index + 1].join.to_i
      rotations << rotation
    end
    rotations.pop
    return rotations
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
        starting_index = @character_map.index(character)
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

  def find_last_four_encrypted_characters(encrypted_message)
    encrypted_message_split = split_message_every_four_characters(encrypted_message)
    if encrypted_message_split[-1].length == 4
      last_full_block = encrypted_message_split[-1]
    else
      last_full_block = encrypted_message_split[-2]
    end
    return last_full_block
  end

  def find_last_four_decrypted_characters(encrypted_message)
    encrypted_message_split = split_message_every_four_characters(encrypted_message)
    if encrypted_message_split[-1].length == 3
      decrypted_ending = [".", ".", "e", "n"]
    elsif encrypted_message_split[-1].length == 2
      decrypted_ending = [".", "e", "n", "d"]
    elsif encrypted_message_split[-1].length == 1
      decrypted_ending = ["e", "n", "d", "."]
    else
      decrypted_ending = ["n", "d", ".", "."]
    end
    return decrypted_ending
  end

  def crack_shifts(encrypted_message)
    shifts = []
    create_character_map
    last_four_encrypted = find_last_four_encrypted_characters(encrypted_message)
    last_four_decrypted = find_last_four_decrypted_characters(encrypted_message)

    last_four_encrypted.each_with_index do |character, i|
      decrypted_index = @character_map.index(last_four_decrypted[i])
      rotated_character_map = @character_map.rotate(decrypted_index)
      encrypted_index = rotated_character_map.index(last_four_encrypted[i])
      shifts << encrypted_index
    end
     return shifts
  end

  def crack(encrypted_message)
    shifts = crack_shifts(encrypted_message)
    convert_rotations_to_key(encrypted_message)
    cracked_array = []
    character_map_reversed = create_character_map.reverse
    split_message = split_message_every_four_characters(encrypted_message)

    split_message.each do |four_characters|
      four_characters.each_with_index do |character, index|
        starting_index = character_map_reversed.index(four_characters[index])
        rotated_character_map = character_map_reversed.rotate(starting_index)
        cracked_index = starting_index + shifts[index]
        cracked_array << character_map_reversed[cracked_index]
      end
    end
    return cracked_array.join("")
  end

  def discover_rotations(encrypted_message)
    find_shift = crack_shifts(encrypted_message)
    rotations_array = []
    find_shift.each_with_index do |shift, index|
        if shift - @offsets[index] < 11
          rotations_array << (shift - @offsets[index]) + 85
        else
          rotations_array << shift - @offsets[index]
        end
    end
    return rotations_array
  end

  def convert_rotations_to_key(encrypted_message)
    rotation_arr = discover_rotations(encrypted_message)
    rotation_string = rotation_arr.join('')
    @key = rotation_string[0..1] + rotation_string[3] + rotation_string[6..7]
  end
end
