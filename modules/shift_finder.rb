module ShiftFinder

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
    date.delete_at(-3)
    date.join
  end

  def generate_keys(key = generate_five_digits)
      temp = []
      key.split("")
        .map(&:to_i)
        .each_cons(2) { |i| temp << i.join.to_i }
      temp
  end


  def generate_offsets(date = generate_date)
    if date[0] == '0'
      date_sqr = date[1..-1].to_i ** 2
    else
      date_sqr = date.to_i ** 2
    end

    date_sqr.to_s.split("").map(&:to_i)[-4..-1]
  end

  def shift_by_class(key, offset)
    chars = %w[A B C D]
    chars.map!(&:to_sym)
    shift = []
    4.times do |i|
      shift << ((generate_keys(key)[i] + generate_offsets(offset)[i]) % 27)
    end
    # binding.pry
    Hash[chars.zip(shift)]
  end

end
