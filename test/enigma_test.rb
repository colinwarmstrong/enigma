require './test/test_helper.rb'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test

  def test_it_exists
    rotations = [2, 3, 4, 5]
    offsets = [2, 3, 4, 5]
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_calculating_shift_correctly_adds_rotations_and_offsets
    enigma = Enigma.new

    assert_equal 4, enigma.calculating_shifts.count
    assert_instance_of Array, enigma.calculating_shifts
  end

  def test_has_character_map
    enigma = Enigma.new
    character_map = enigma.create_character_map

    assert character_map.include?("a")
    assert character_map.include?("8")
    assert character_map.include?(",")
    assert character_map.include?("B")
    assert_equal 255, character_map.length
  end

  def test_can_split_message_into_four_characters
    message = "Hello1!"
    enigma = Enigma.new
    split_message = enigma.split_message_every_four_characters(message)
    assert_equal 4, split_message[0].length
  end

  def test_can_encrypt_a_message
    message = "Hello1!"
    enigma = Enigma.new

    assert_equal 7, enigma.encrypt(message).length
    assert_instance_of String, enigma.encrypt(message)
  end

  def test_can_a_different_message
    # is this redundant or helpful?
  end

  def test_can_decrypt_a_message
    encrypted_message = "Lktvs7("
    enigma = Enigma.new

    assert_equal 7, enigma.decrypt(encrypted_message).length
    assert_instance_of String, enigma.decrypt(encrypted_message)
  end

  def test_knowing_length_of_last_block_of_characters
    encrypted_message = "Lktvs7("
    enigma = Enigma.new
    last_full_block = enigma.find_last_four_encrypted_characters(encrypted_message)

    assert_equal 4, last_full_block.length
    assert_instance_of Array, last_full_block
  end

  def test_finding_last_four_decrypted_characters
    enigma = Enigma.new
    encrypted_message = "Lktvs7("

    assert_instance_of Array, enigma.find_last_four_decrypted_characters(encrypted_message)
    assert_equal 4, enigma.find_last_four_decrypted_characters(encrypted_message).length
  end

  def test_finding_shift_numbers
    enigma = Enigma.new

    assert_instance_of Array, enigma.find_shift_numbers
    assert_equal 4, enigma_find_shift_numbers
  end


end
