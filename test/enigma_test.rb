require './test/test_helper.rb'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test

  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
  end

  def test_can_define_rotations
    enigma = Enigma.new

    assert_equal [12, 23, 34, 45], enigma.define_rotations([1, 2, 3, 4, 5])
  end

  def test_calculate_shifts_correctly_adds_rotations_and_offsets
    key = [1, 2, 3, 4, 5]
    date = 150518
    enigma = Enigma.new(key, date)

    assert_equal [20, 26, 36, 49], enigma.calculate_shifts
  end

  def test_has_correct_character_map
    enigma = Enigma.new
    character_map = enigma.create_character_map

    assert character_map.include?('a')
    assert character_map.include?('8')
    assert character_map.include?('>')
    assert character_map.include?('B')
    assert_equal 85, character_map.length
  end

  def test_can_split_message_into_four_characters
    message = "Hello1!"
    enigma = Enigma.new

    split_message = enigma.split_message_every_four_characters(message)
    assert_equal ['H', 'e', 'l', 'l'], split_message[0]
    assert_equal ['o', '1', '!'], split_message[1]
  end

  def test_can_correctly_shift_each_character
    enigma = Enigma.new([1, 2, 1, 2, 1], 150518)
    split_message = [['H', 'e', 'l', 'l'], ['o', '1', '!']]
    shifts = enigma.calculate_shifts

    assert_equal ['1', 'C', 'z', 'K', 'I', '<','<'], enigma.shift_each_character(shifts, split_message)
  end

  def test_can_encrypt_a_message
    message1 = "Hello1!..end.."
    message2 = "wElcOme$$#%..end.."
    enigma = Enigma.new([1, 2, 1, 2, 1], 150518)

    assert_equal "1CzKI<<qlCBClp", enigma.encrypt(message1)
    assert_equal "Q2zB8Ksgbe/qlCBClp", enigma.encrypt(message2)
  end

  def test_can_decrypt_a_message
    encrypted_message1 = "1CzKI<<qlCBClp"
    encrypted_message2 = "Q2zB8Ksgbe/qlCBClp"
    enigma = Enigma.new([1, 2, 1, 2, 1], 150518)

    assert_equal "Hello1!..end..", enigma.decrypt(encrypted_message1)
    assert_equal "wElcOme$$#%..end..", enigma.decrypt(encrypted_message2)
  end

  def test_finding_length_of_last_block_of_characters
    encrypted_message = "Lktvs7("
    enigma = Enigma.new
    last_full_block = enigma.find_last_four_encrypted(encrypted_message)

    assert_equal 4, last_full_block.length
    assert_instance_of Array, last_full_block
  end

  def test_finding_last_four_decrypted_characters
    enigma = Enigma.new
    encrypted_message = "Lktvs7("

    assert_instance_of Array, enigma.find_last_four_decrypted(encrypted_message)
    assert_equal 4, enigma.find_last_four_decrypted(encrypted_message).length
  end

  def test_cracking_shifts
    enigma = Enigma.new
    encrypted_message = "Lktvs7("
    last_four_encrypted = enigma.find_last_four_encrypted(encrypted_message)
    last_four_decrypted = enigma.find_last_four_decrypted(encrypted_message)

    assert_instance_of Array, enigma.crack_shifts(last_four_encrypted, last_four_encrypted)
    assert_equal 4, enigma.crack_shifts(last_four_encrypted, last_four_decrypted).length
  end

  def test_can_crack_encrypted_message
    enigma = Enigma.new
    encrypted_message = enigma.encrypt("Hello1!..end..")

    assert_equal enigma.decrypt(encrypted_message), enigma.crack(encrypted_message)
  end

  def test_can_discover_rotations_array
    enigma = Enigma.new
    encrypted_message = enigma.encrypt("Hello1!..end..")

    assert_equal 4, enigma.crack_rotations(encrypted_message).length
  end

  def convert_rotations_array_into_5_digits_key
    enigma = Enigma.new
    encrypted_message = enigma.encrypt("Hello1!..end..")

    assert_equal 5, enigma.convert_rotations_to_key(encrypted_message)
  end

end
