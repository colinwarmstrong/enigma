require './test/test_helper.rb'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test

  def test_it_exists
    rotations = [2, 3, 4, 5]
    offsets = [2, 3, 4, 5]
    enigma = Enigma.new(rotations, offsets)

    assert_instance_of Enigma, enigma
  end

  def test_calculating_shift_correctly_adds_rotations_and_offsets
    enigma = Enigma.new([2, 3, 4, 5], [2, 3, 4, 5])

    assert_equal [4, 6, 8, 10], enigma.calculating_shifts
  end

  def test_has_character_map
    enigma = Enigma.new([2, 3, 4, 5], [2, 3, 4, 5])
    character_map = enigma.create_character_map

    assert character_map.include?("a")
    assert character_map.include?("8")
    assert character_map.include?(",")
    assert character_map.include?("B")
    assert_equal 255, character_map.length
  end

  def test_can_split_message_into_four_characters
    message = "Hello1!"
    enigma = Enigma.new([2, 3, 4, 5], [2, 3, 4, 5])
    split_message = enigma.split_message_every_four_characters(message)
    assert_equal 4, split_message[0].length
  end

  def test_can_encrypt_a_message
    message = "Hello1!"
    enigma = Enigma.new([2, 3, 4, 5], [2, 3, 4, 5])

    assert_equal "Lktvs7(", enigma.encrypt(message)
  end

  def test_can_a_different_message
    # is this redundant or helpful?
  end

  def test_can_decrypt_a_message
    encrypted_message = "Lktvs7("
    engima = Enigma.new([2, 3, 4, 5], [2, 3, 4, 5])

    assert_equal "Hello1!", engima.decrypt(encrypted_message)
  end

end
