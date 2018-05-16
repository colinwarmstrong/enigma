require './lib/key_generator'
require './lib/offsets_calculator'
require 'date'

class Enigma

  def initialize(key = KeyGenerator.new.generate_key, date = Date.today.strftime("%d%m%y").to_i)
    @rotations = define_rotations(key)
    @offsets = OffsetsCalculator.new.define_offsets(date)
    @character_map = create_character_map
  end

  def define_rotations(key)
    rotations = key.map.with_index do |digit, index|
                      key[index..index + 1].join.to_i
                     end
    rotations.pop
    return rotations
  end

  def calculate_shifts
    shifts = @rotations.map.with_index do |number, index|
              number + @offsets[index]
             end
    return shifts
  end

  def create_character_map
    @character_map = []
    ("a".."z").each do |lowercase_letter|
      @character_map << lowercase_letter
    end
    ("A".."Z").each do |uppercase_letter|
      @character_map << uppercase_letter
    end
    ("0".."9").each do |number|
      @character_map << number
    end
    @character_map << [' ', '!', '@', '#', '$', '%', '^', '&']
    @character_map << ['*', '(', ')', '[', ']', ',', '.', '<']
    @character_map << ['>', ';', ':', '/', '?', "\\", '|' ]
    @character_map.flatten!
  end

  def split_message_every_four_characters(message)
    split_message = []
    message_array = message.split('')
    while message_array.length != 0
      split_message << message_array.shift(4)
    end
    return split_message
  end

  def shift_each_character(shifts, split_message)
    shifted_array = []
    split_message.each do |four_characters|
      four_characters.each_with_index do |character, index|
        initial_index = @character_map.index(character)
        rotated_character_map = @character_map.rotate(shifts[index])
        shifted_character = rotated_character_map[initial_index]
        shifted_array << shifted_character
      end
    end
    return shifted_array
  end

  def encrypt(message)
    shifts = calculate_shifts
    split_message = split_message_every_four_characters(message)
    return shift_each_character(shifts, split_message).join("")
  end

  def decrypt(encrypted_message)
    shifts = calculate_shifts.map {|shift| shift * -1}
    split_message = split_message_every_four_characters(encrypted_message)
    return shift_each_character(shifts, split_message).join("")
  end

  def find_last_four_encrypted(encrypted_message)
    encrypted_message_split = split_message_every_four_characters(encrypted_message)
    if encrypted_message_split[-1].length == 4
      encrypted_ending = encrypted_message_split[-1]
    else
      encrypted_ending = encrypted_message_split[-2]
    end
    return encrypted_ending
  end

  def find_last_four_decrypted(encrypted_message)
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

  def crack_shifts(last_four_encrypted, last_four_decrypted)
    shifts = []
    last_four_encrypted.each_with_index do |character, i|
      decrypted_index = @character_map.index(last_four_decrypted[i])
      rotated_character_map = @character_map.rotate(decrypted_index)
      encrypted_index = rotated_character_map.index(last_four_encrypted[i])
      shifts << encrypted_index
    end
     return shifts
  end

  def crack(encrypted_message)
    last_four_encrypted = find_last_four_encrypted(encrypted_message)
    last_four_decrypted = find_last_four_decrypted(encrypted_message)
    shifts = crack_shifts(last_four_encrypted, last_four_decrypted)
    shifts.map! {|shift| shift * -1}
    split_message = split_message_every_four_characters(encrypted_message)
    return shift_each_character(shifts, split_message).join("")
  end

  def crack_rotations(encrypted_message)
    last_four_encrypted = find_last_four_encrypted(encrypted_message)
    last_four_decrypted = find_last_four_decrypted(encrypted_message)
    find_shift = crack_shifts(last_four_encrypted, last_four_decrypted)
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
    rotation_arr = crack_rotations(encrypted_message)
    rotation_string = rotation_arr.join('')
    @key = rotation_string[0..1] + rotation_string[3] + rotation_string[6..7]
  end
end
