require 'date'

class Offset

  attr_reader :date, :default

  def initialize(date = Offset.default)
    @date = date
  end

  def self.default
    Date.today.strftime("%d%m%y")
  end

  def generate_offsets
    (@date.to_i ** 2).to_s[-4..-1].split("").map(&:to_i)
  end
end
