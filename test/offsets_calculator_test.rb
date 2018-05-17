require './test/test_helper'
require './lib/offsets_calculator.rb'
require 'date'

class OffsetsCalculatorTest < Minitest::Test

  def test_it_exists
    offsets_calculator = OffsetsCalculator.new

    assert_instance_of OffsetsCalculator, offsets_calculator
  end

  def test_it_can_square_numeric_date
    offsets_calculator = OffsetsCalculator.new
    numeric_date1 = 150_218
    numeric_date2 = 140_706

    assert_equal 22_565_447_524, offsets_calculator.square_numeric_date(numeric_date1)
    assert_equal 19_798_178_436, offsets_calculator.square_numeric_date(numeric_date2)
  end

  def test_define_offsets
    offsets_calculator1 = OffsetsCalculator.new
    offsets_calculator2 = OffsetsCalculator.new

    assert_equal [7, 5, 2, 4], offsets_calculator1.define_offsets(150_218)
    assert_equal [8, 4, 3, 6], offsets_calculator2.define_offsets(140_706)
  end

end
