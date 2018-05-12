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


end
