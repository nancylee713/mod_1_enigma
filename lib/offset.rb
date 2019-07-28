require 'date'

class Offset

  attr_accessor :date

  def initialize(date = generate_date)
    @date = date
  end

  def generate_date
    Date.today.strftime("%d%m%y")
  end

  def generate_offsets
    (date.to_i ** 2).to_s[-4..-1].split("").map(&:to_i)
  end
end
