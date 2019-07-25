class ShiftFinder

  attr_reader :charset

  def initialize
    @charset= ("a".."z").to_a << " "
  end

  def generate_five_digits
    (0..9).to_a.shuffle[0..4].join
  end

  def generate_date
    date = Time.new.strftime("%d%m%Y").split("")
    date.delete_at(-3)
    date.delete_at(-4)
    date.join
  end

  def generate_keys
    key_a = generate_five_digits[0..1].to_i
    key_b = generate_five_digits[1..2].to_i
    key_c = generate_five_digits[2..3].to_i
    key_d = generate_five_digits[3..4].to_i
    [key_a, key_b, key_c, key_d]
  end


  def generate_offsets
    date = generate_date

    if date[0] == '0'
      date_sqr = date[1..-1].to_i ** 2
    else
      date_sqr = date.to_i ** 2
    end

    last_four = date_sqr.to_s.split("").map(&:to_i)[-4..-1]
    offset_a = last_four[0]
    offset_b = last_four[1]
    offset_c = last_four[2]
    offset_d = last_four[3]
    [offset_a, offset_b, offset_c, offset_d]
  end

  def shift_by_class
    chars = %w[A B C D]
    shift = []
    4.times { |i| shift << (generate_keys[i] + generate_offsets[i]) % 27 }
    Hash[chars.zip(shift)].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

end
