class Shift
  attr_reader :key, :offset, :char_set

  def initialize(key, offset)
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

  def shift_chars(str)
    str.split("").map do |char|
      next char unless char_set.include? char

      if str.index(char) % 4 == 0
        (char.ord + generate_final_shift[:A])
      elsif str.index(char) % 4 == 1
        (char.ord + generate_final_shift[:B])
      elsif str.index(char) % 4 == 2
        (char.ord + generate_final_shift[:C])
      elsif str.index(char) % 4 == 3
        (char.ord + generate_final_shift[:D])
      end
    end
  end

  def rotate_chars(str)
    shift_chars(str).map do |i|
      next i if i.class == String
      i > 122 ? (i - 27) : i
    end
  end

  def convert_ord_to_chr
    rotate_chars(str).map do |i|
      next i if i.class == String
      i.chr
    end
  end

end
