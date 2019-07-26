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

  def shift_by_class
    shift = Hash.new(0)
    shift[:A] = generate_keys[0] + generate_offsets[0]
    shift[:B] = generate_keys[1] + generate_offsets[1]
    shift[:C] = generate_keys[2] + generate_offsets[2]
    shift[:D] = generate_keys[3] + generate_offsets[3]
    shift
  end

end
