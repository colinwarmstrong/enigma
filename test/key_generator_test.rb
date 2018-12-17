require './test/test_helper'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test
  def test_it_exists
    key_generator = KeyGenerator.new

    assert_instance_of KeyGenerator, key_generator
  end

  def test_key_has_a_length_of_five
    key_generator = KeyGenerator.new

    assert_equal 5, key_generator.generate_key.length
  end

  def test_it_can_generate_a_random_number_1_to_9
    key_generator = KeyGenerator.new

    key = key_generator.generate_key
    assert_instance_of String, key
    assert key[0].to_i.between?(0, 10)
    assert key[3].to_i.between?(0, 10)
    refute key.include?('0')
  end
end
