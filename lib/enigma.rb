require './lib/key_generator'
require './lib/offsets_calculator'
require 'date'

class Enigma
  def initialize
    @character_map = create_character_map
  end

  def create_character_map
    @character_map = []
    @character_map << ('a'..'z').to_a
    @character_map << ('A'..'Z').to_a
    @character_map << ('0'..'9').to_a
    @character_map << [' ', '!', '@', '#', '$', '%', '^', '&']
    @character_map << ['*', '(', ')', '[', ']', ',', '.', '<']
    @character_map << ['>', ';', ':', '/', '?', '\\', '|']
    @character_map.flatten!
  end

  def define_rotations(key)
    key.map!.with_index do |_, index|
      key[index..index + 1].join.to_i
    end.pop
    key
  end

  def calculate_shifts(rotations, offsets)
    rotations.map.with_index do |number, index|
      number + offsets[index]
    end
  end

  def split_message_every_four_characters(message)
    split_message = []
    message_array = message.split('')
    split_message << message_array.shift(4) until message_array.empty?
    split_message
  end

  def shift_each_character(shifts, split_message)
    split_message.map do |four_characters|
      four_characters.map.with_index do |character, index|
        initial_index = @character_map.index(character)
        rotated_character_map = @character_map.rotate(shifts[index])
        rotated_character_map[initial_index]
      end
    end.flatten
  end

  def encrypt(message, key = KeyGenerator.new.generate_key, date = Date.today.strftime("%d%m%y"))
    rotations = define_rotations(key.to_i.digits.reverse)
    offsets = OffsetsCalculator.new.define_offsets(date.to_i)
    shifts = calculate_shifts(rotations, offsets)
    split_message = split_message_every_four_characters(message)
    shift_each_character(shifts, split_message).join('')
  end

  def decrypt(encrypted_message, key, date = Date.today.strftime('%d%m%y'))
    rotations = define_rotations(key.to_i.digits.reverse)
    offsets = OffsetsCalculator.new.define_offsets(date.to_i)
    shifts = calculate_shifts(rotations, offsets).map { |shift| shift * -1 }
    split_message = split_message_every_four_characters(encrypted_message)
    shift_each_character(shifts, split_message).join('')
  end

  def find_last_four_encrypted(split_message)
    if split_message[-1].length == 4
      split_message[-1]
    else
      split_message[-2]
    end
  end

  def find_last_four_decrypted(split_message)
    if split_message[-1].length == 3
      ['.', '.', 'e', 'n']
    elsif split_message[-1].length == 2
      ['.', 'e', 'n', 'd']
    elsif split_message[-1].length == 1
      ['e', 'n', 'd', '.']
    else
      ['n', 'd', '.', '.']
    end
  end

  def crack_shifts(last_four_encrypted, last_four_decrypted)
    last_four_encrypted.map.with_index do |_, i|
      decrypted_index = @character_map.index(last_four_decrypted[i])
      rotated_character_map = @character_map.rotate(decrypted_index)
      rotated_character_map.index(last_four_encrypted[i])
    end
  end

  def crack(encrypted_message, date = Date.today.strftime('%d%m%y').to_i)
    split_message = split_message_every_four_characters(encrypted_message)
    crack_rotations(encrypted_message, date)
    last_four_encrypted = find_last_four_encrypted(split_message)
    last_four_decrypted = find_last_four_decrypted(split_message)
    shifts = crack_shifts(last_four_encrypted, last_four_decrypted)
    shifts.map! { |shift| shift * -1 }
    shift_each_character(shifts, split_message).join('')
  end

  def crack_rotations(encrypted_message, date)
    split_message = split_message_every_four_characters(encrypted_message)
    offsets = OffsetsCalculator.new.define_offsets(date)
    last_four_encrypted = find_last_four_encrypted(split_message)
    last_four_decrypted = find_last_four_decrypted(split_message)
    shifts = crack_shifts(last_four_encrypted, last_four_decrypted)
    rotations = adjust_rotations(shifts, offsets)
    rotations
  end

  def adjust_rotations(shifts, offsets)
    shifts.map.with_index do |shift, index|
      if (shift - offsets[index]) < 11
        shift - offsets[index] + 85
      else
        shift - offsets[index]
      end
    end
  end

  def convert_rotations_to_key(encrypted_message, date = Date.today.strftime('%d%m%y').to_i)
    rotation_arr = crack_rotations(encrypted_message, date)
    rotation_string = rotation_arr.join('')
    key = rotation_string[0..1] + rotation_string[3] + rotation_string[6..7]
    key
  end
end
