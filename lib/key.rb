class Key

  attr_accessor :string

  def initialize(string = Key.default)
    @string = string
  end

  def self.preprocess_input(string)
    if string.class == String
      if string.scan(/\D/).empty? && (string.length < 5)
        string.rjust(5, "0")
      else
        puts "Input must be 5-digit long, wrapped in a string."
      end
    else
      puts "Input must be 5-digit long, wrapped in a string."
    end
  end

  def self.default
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
