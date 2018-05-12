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

    rotations = key_generator.define_rotations
    assert_equal 4, rotations.length
    assert_instance_of Integer, rotations[0]
  end

end
