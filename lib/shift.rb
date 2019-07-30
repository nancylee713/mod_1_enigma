class Shift
  attr_reader :key, :offset

  def initialize(key, offset)
    @key = key
    @offset = offset
  end

  def combine_key_and_offset
    pair = @key.split_by_letter.zip(@offset.generate_offsets)
    pair.map(&:sum)
  end

  def generate_final_shift
    chars = [:A, :B, :C, :D]
    Hash[chars.zip(combine_key_and_offset)]
  end

  def convert_chr_to_ord(message)
    message.sub!(" ", "`")
    message_ord = message.scan(/.{1,4}/)
      .map { |str| str.split("").map(&:ord) }
  end

  def apply_shift(message)
    convert_chr_to_ord(message).each do |arr|
      arr[0] += generate_final_shift[:A]
      arr[1] += generate_final_shift[:B]
      arr[2] += generate_final_shift[:C]
      arr[3] += generate_final_shift[:D] unless arr[3] == nil
    end
  end
end
