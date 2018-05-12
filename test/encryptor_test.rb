require 'minitest/autorun'
require 'minitest/pride'
require './lib/offsets_calculator.rb'
require './lib/encryptor'
require './lib/key_generator'

class EncryptorTest < Minitest::Test

  def test_it_exists
    rotations = [2, 3, 4, 5]
    offsets = [2, 3, 4, 5]
    encryptor = Encryptor.new(message, rotations, offsets)

    assert_instance_of Encryptor, encryptor
  end

  def test_calculating_shift_correctly_adds_rotations_and_offsets
    encryptor = Encryptor.new(message, [2, 3, 4, 5], [2, 3, 4, 5])

    assert_equal [4, 6, 8, 10], encryptor.calculating_shifts
  end

  def test_has_character_map
    encryptor = Encryptor.new(message, [2, 3, 4, 5], [2, 3, 4, 5])
    character_map = encryptor.creates_character_map

    assert character_map.include?("a")
    assert character_map.include?("8")
    assert character_map.include?(",")
    assert character_map.include?("B")
    assert_equal 255, character_map.length
  end

  def test_can_split_message_into_four_characters
    message = "Hello1!"
    encryptor = Encryptor.new(message, [2, 3, 4, 5], [2, 3, 4, 5])

    assert_equal 4, encryptor.split_message_every_4_characters[0].length
  end



end
