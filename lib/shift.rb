class Shift
  attr_reader :key, :offset

  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def combine_key_and_offset
    pair = @key.split_by_letter.zip(@offset.generate_offsets)
    pair.map(&:sum)
      .map { |n| n % 27 }
  end

  def generate_final_shift
    chars = [:A, :B, :C, :D]
    Hash[chars.zip(combine_key_and_offset)]
  end

  def arrange_chars_by_shift(message)
    temp_arr = message.split("").each_slice(4).to_a
    until temp_arr.first.length == temp_arr.last.length
      temp_arr.last.push(0)
    end
    temp_arr.transpose
  end
end
