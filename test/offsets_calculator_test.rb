require 'minitest/autorun'
require 'minitest/pride'
require './lib/offsets_calculator.rb'
require 'date'

class OffsetsCalculatorTest < Minitest::Test

  def test_it_exists
    offsets_calculator = OffsetsCalculator.new

    assert_instance_of OffsetsCalculator, offsets_calculator
  end

  def test_format_date_to_numeric_returns_date_in_correct_form
    offsets_calculator = OffsetsCalculator.new

    date_in_numeric_form = offsets_calculator.format_date_to_numeric
    assert_equal 6, date_in_numeric_form.digits.length
    assert_instance_of Integer, date_in_numeric_form
  end

  def test_it_can_square_numeric_date
    offsets_calculator = OffsetsCalculator.new
    numeric_date = 150218

    assert_equal 22565447524, offsets_calculator.square_numeric_date(numeric_date)
  end

  def test_if_we_can_find_last_four_digits_of_numeric
    offsets_calculator = OffsetsCalculator.new

    assert_equal ['2', '3', '4', '1'], offsets_calculator.find_last_four_digits_of_squared_numeric(92341)
  end

  def test_if_we_return_correct_offsets
    offsets_calculator = OffsetsCalculator.new

    assert_instance_of Array, offsets_calculator.define_offsets
    assert_equal 4, offsets_calculator.define_offsets.count
  end

end
