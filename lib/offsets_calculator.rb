require 'date'

class OffsetsCalculator

  attr_reader :date

  def initialize(date = Date.today)
    @date = date
  end

  def format_date_to_numeric
    date_string = @date.to_s
    day = date_string[8..9]
    month = date_string[5..6]
    year = date_string[2..3]
    date_string_formatted = day + month + year
    numeric_date = date_string_formatted.to_i
    return numeric_date
  end

  def square_numeric_date(numeric_date)
    return numeric_date ** 2
  end

  def find_last_four_digits_of_squared_numeric(squared_numeric)
    last_four_digits = []
    squared_numeric_array = squared_numeric.to_s.split("")
    last_four_digits.push(squared_numeric_array[-4..-1])
    last_four_digits.flatten!
    return last_four_digits
  end

  def define_offsets
    numeric_date = format_date_to_numeric
    numeric_date_squared = square_numeric_date(numeric_date)
    last_four_digits = find_last_four_digits_of_squared_numeric(numeric_date_squared)
    offsets = last_four_digits.map do |digit|
      digit.to_i
    end
    return offsets
  end

end
