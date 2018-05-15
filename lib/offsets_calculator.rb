require 'date'

class OffsetsCalculator
  attr_reader :date

  def initialize(date = Date.today.strftime("%d%m%y"))
    @date = date.to_i
  end

  def square_numeric_date(date)
    return date ** 2
  end

  def define_offsets
    square_num = square_numeric_date(@date)
    squared_numeric_array = square_num.digits.reverse
    offsets = squared_numeric_array[-4..-1]
    return offsets
  end

end
