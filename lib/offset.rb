require 'date'

class Offset

  attr_reader :date

  def initialize(date = Date.today.strftime("%d%m%y"))
    @date = date
  end

  def generate_offsets
    (@date.to_i ** 2).to_s[-4..-1].split("").map(&:to_i)
  end
end
