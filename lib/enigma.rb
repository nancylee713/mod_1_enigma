class Enigma

  attr_reader :char_set

  def initialize
    @char_set = ("a".."z").to_a << " "
  end

  def encrypt(string, key, date)
    temp_arr = string.split("")
    shifted_arr = []
    shift = Shift.new(key, date)

    temp_arr.map do |i|
      shifted_arr << char_set[temp_arr.index(i) + shift.generate_final_shift]
    end

    shifted_arr.join
  end

end
