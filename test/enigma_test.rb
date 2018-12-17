require './test/test_helper.rb'
require './lib/enigma.rb'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new

    assert_instance_of Enigma, enigma
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

  def test_can_define_rotations
    enigma = Enigma.new

    assert_equal [12, 23, 34, 45], enigma.define_rotations([1, 2, 3, 4, 5])
    assert_equal [72, 29, 96, 63], enigma.define_rotations([7, 2, 9, 6, 3])
  end

  def test_calculate_shifts_correctly_adds_rotations_and_offsets
    enigma = Enigma.new
    rotations1 = enigma.define_rotations([1, 2, 3, 4, 5])
    rotations2 = enigma.define_rotations([7, 2, 9, 6, 3])
    offsets = OffsetsCalculator.new.define_offsets(150_518)

    assert_equal [20, 26, 36, 49], enigma.calculate_shifts(rotations1, offsets)
    assert_equal [80, 32, 98, 67], enigma.calculate_shifts(rotations2, offsets)
  end

  def test_can_split_message_into_four_characters
    message = 'Hello1!'
    enigma = Enigma.new

    split_message = enigma.split_message_every_four_characters(message)
    assert_equal ['H', 'e', 'l', 'l'], split_message[0]
    assert_equal ['o', '1', '!'], split_message[1]
  end

  def test_can_correctly_shift_each_character
    enigma = Enigma.new
    split_message1 = [['H', 'e', 'l', 'l'], ['o', '1', '!']]
    rotations = enigma.define_rotations([1, 2, 1, 2, 1])
    offsets = OffsetsCalculator.new.define_offsets(150_518)
    shifts = enigma.calculate_shifts(rotations, offsets)

    assert_equal ['1', 'C', 'z', 'K', 'I', '<', '<'], enigma.shift_each_character(shifts, split_message1)
  end

  def test_can_encrypt_a_message
    message1 = 'Hello1!..end..'
    message2 = 'wElcOme$$#%..end..'
    enigma = Enigma.new

    assert_equal '1CzKI<<qlCBClp', enigma.encrypt(message1, '12121', 150_518)
    assert_equal 'Q2zB8Ksgbe/qlCBClp', enigma.encrypt(message2, '12121', 150_518)
  end

  def test_can_decrypt_a_message
    encrypted_message1 = '1CzKI<<qlCBClp'
    encrypted_message2 = 'Q2zB8Ksgbe/qlCBClp'
    enigma = Enigma.new

    assert_equal 'Hello1!..end..', enigma.decrypt(encrypted_message1, '12121', 150518)
    assert_equal 'wElcOme$$#%..end..', enigma.decrypt(encrypted_message2, '12121', 150518)
  end

  def test_finding_last_full_block_of_encrypted_characters
    encrypted_message1 = 'Lktvs7('
    encrypted_message2 = '1@aGSxc!'
    enigma = Enigma.new
    split_message1 = enigma.split_message_every_four_characters(encrypted_message1)
    split_message2 = enigma.split_message_every_four_characters(encrypted_message2)

    assert_equal ['L', 'k', 't', 'v'], enigma.find_last_four_encrypted(split_message1)
    assert_equal ['S', 'x', 'c', '!'],  enigma.find_last_four_encrypted(split_message2)
  end

  def test_finding_last_full_block_of_decrypted_characters
    encrypted_message1 = 'Lktvs7('
    encrypted_message2 = '1@aGSxc!'
    enigma = Enigma.new
    split_message1 = enigma.split_message_every_four_characters(encrypted_message1)
    split_message2 = enigma.split_message_every_four_characters(encrypted_message2)

    assert_equal ['.', '.', 'e', 'n'], enigma.find_last_four_decrypted(split_message1)
    assert_equal ['n', 'd', '.', '.'], enigma.find_last_four_decrypted(split_message2)
  end

  def test_cracking_shifts
    enigma = Enigma.new
    encrypted_message1 = '1CzKI<<qlCBClp'
    encrypted_message2 = 'Q2zB8Ksgbe/qlCBClp'
    split_message1 = enigma.split_message_every_four_characters(encrypted_message1)
    split_message2 = enigma.split_message_every_four_characters(encrypted_message2)
    last_four_encrypted1 = enigma.find_last_four_encrypted(split_message1)
    last_four_encrypted2 = enigma.find_last_four_encrypted(split_message2)
    last_four_decrypted1 = enigma.find_last_four_decrypted(split_message1)
    last_four_decrypted2 = enigma.find_last_four_decrypted(split_message2)

    assert_equal [20, 24, 14, 25], enigma.crack_shifts(last_four_encrypted1, last_four_decrypted1)
    assert_equal [20, 24, 14, 25], enigma.crack_shifts(last_four_encrypted2, last_four_decrypted2)
  end

  def test_can_crack_encrypted_message
    enigma = Enigma.new
    encrypted_message1 = enigma.encrypt('Hello1!..end..', '10000', 150_518)
    encrypted_message2 = enigma.encrypt('wElcOme$$#%..end..', '10000', 150_518)

    assert_equal 'Hello1!..end..', enigma.crack(encrypted_message1, 150_518)
    assert_equal 'wElcOme$$#%..end..', enigma.crack(encrypted_message2, 150_518)
  end

  def test_can_crack_rotations
    enigma = Enigma.new
    encrypted_message1 = enigma.encrypt('Hello1!..end..', '12121', 150_518)
    encrypted_message2 = enigma.encrypt('wElcOme$$#%..end..', '64583', 150_518)

    assert_equal [12, 21, 12, 21], enigma.crack_rotations(encrypted_message1, 150_518)
    assert_equal [64, 45, 58, 83], enigma.crack_rotations(encrypted_message2, 150_518)
  end

  def test_it_can_convert_rotations_array_into_5_digit_key
    enigma = Enigma.new
    encrypted_message1 = enigma.encrypt('Hello1!..end..', '12121', 150_518)
    encrypted_message2 = enigma.encrypt('wElcOme$$#%..end..', '81648', 150_518)

    assert_equal '12121', enigma.convert_rotations_to_key(encrypted_message1, 150_518)
    assert_equal '81648', enigma.convert_rotations_to_key(encrypted_message2, 150_518)
  end
end
