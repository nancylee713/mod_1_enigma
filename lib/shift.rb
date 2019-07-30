class Shift
  attr_reader :key, :offset, :char_set

  def initialize(key = Key.new, offset = Offset.new)
    @key = key
    @offset = offset
    @char_set = ("a".."z").to_a << " "
  end

  def combine_key_and_offset
    pair = @key.split_by_letter.zip(@offset.generate_offsets)
    pair.map(&:sum)
      .map { |x| x % 27 }
  end

  def generate_final_shift
    chars = [:A, :B, :C, :D]
    Hash[chars.zip(combine_key_and_offset)]
  end

  def shift_chars(str, dir = 1)
    str.downcase
      .split("")
      .map!.with_index do |val, index|
        next val unless char_set.include? val

        rotated_set = char_set.rotate(char_set.index(val))

        if index % 4 == 0
          rotated_set[generate_final_shift[:A] * dir]
        elsif index % 4 == 1
          rotated_set[generate_final_shift[:B] * dir]
        elsif index % 4 == 2
          rotated_set[generate_final_shift[:C] * dir]
        elsif index % 4 == 3
          rotated_set[generate_final_shift[:D] * dir]
        end
      end.join
  end
end
