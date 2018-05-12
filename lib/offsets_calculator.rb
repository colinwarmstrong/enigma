require 'date'
require 'pry'

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






end
