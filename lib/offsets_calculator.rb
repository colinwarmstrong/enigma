require 'date'

class OffsetsCalculator

  def square_numeric_date(date)
    return date ** 2
  end

  def define_offsets(date = Date.today.strftime("%d%m%y").to_i)
    square_num = square_numeric_date(date)
    squared_numeric_array = square_num.digits.reverse
    offsets = squared_numeric_array[-4..-1]
    return offsets
  end

end
