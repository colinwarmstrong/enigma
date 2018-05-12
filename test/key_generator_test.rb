require './test/test_helper'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test

  def test_it_exists
    key_generator = KeyGenerator.new

    assert_instance_of KeyGenerator, key_generator
  end

  def test_key_generator_has_a_length_of_five
    key_generator = KeyGenerator.new

    assert_equal 5, key_generator.key_length
    assert_instance_of Integer, key_generator.key_length
    # is it unecessary?
  end

  def test_it_can_generate_a_random_number_1_to_9
    key_generator = KeyGenerator.new

    assert_instance_of Array, key_generator.generate_random_number
  end

  def test_it_can_define_4_rotations_when_passed_a_key
    key_generator = KeyGenerator.new

    rotations = key_generator.define_rotations([1, 2, 3, 4, 5])
    assert_equal 12, rotations[0]
    assert_equal 23, rotations[1]
    assert_equal 34, rotations[2]
    assert_equal 45, rotations[3]
  end

end
