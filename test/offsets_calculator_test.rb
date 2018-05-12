require 'minitest/autorun'
require 'minitest/pride'
require 'date'
require './lib/offsets_calculator.rb'

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

end
