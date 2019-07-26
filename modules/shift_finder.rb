module ShiftFinder

  attr_reader :charset

  def initialize
    @charset= ("a".."z").to_a << " "
  end

  def shift_by_class(key, offset)
    chars = %w[A B C D]
    chars.map!(&:to_sym)
    shift = []
    4.times do |i|
      shift << ((generate_keys(key)[i] + generate_offsets(offset)[i]) % 27)
    end

    Hash[chars.zip(shift)]
  end

end
