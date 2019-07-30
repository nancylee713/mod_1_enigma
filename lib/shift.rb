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
    str.downcase
      .split("")
      .map!.with_index do |val, index|
        next val unless char_set.include? val
        if index % 4 == 0
          val.ord + generate_final_shift[:A]
        elsif index % 4 == 1
          val.ord + generate_final_shift[:B]
        elsif index % 4 == 2
        val.ord + generate_final_shift[:C]
        elsif index % 4 == 3
        val.ord + generate_final_shift[:D]
        end
      end
  end

  def rotate_chars(str)
    shift_chars(str).map do |i|
      next i if i.class == String

      if i.between?(97, 122)
        i
      elsif i < 97
        i + 64
      elsif i > 122
        i - 123 + 96
      end
    end

  end

  def convert_ord_to_chr(str)
    result = rotate_chars(str).map do |i|
      next i if i.class == String
      i.chr
    end.join.sub("`", " ")

    result
  end

end
