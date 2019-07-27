class Key

  attr_accessor :string

  def initialize(string = generate_five_digits)
    @string = string.rjust(5, "0")
  end

  def all_digits?
    @string.scan(/\D/).empty?
  end

  def is_five?
    @string.count("0-9") == 5
  end


  def generate_five_digits
    (0..9).to_a.shuffle[0..4].join
  end

  def split_by_letter
    temp = []
    @string.split("")
      .map(&:to_i)
      .each_cons(2) { |i| temp << i.join.to_i }
    temp
  end

end
