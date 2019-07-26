require 'date'

class Offset

  attr_reader :date

  def initialize(date = generate_date)
    @date = date
  end

  def generate_date
    Date.today.strftime("%d%m%y")
  end

  def generate_offsets
    if @date[0] == '0'
      date_sqr = date[1..-1].to_i ** 2
    else
      date_sqr = date.to_i ** 2
    end

    date_sqr.to_s.split("").map(&:to_i)[-4..-1]
  end
end
