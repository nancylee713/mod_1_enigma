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
end