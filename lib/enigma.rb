class Enigma

  attr_reader :key, :offset

  def initialize
    @key = Key.new
    @offset = Offset.new
    @shift = Shift.new(@key, @offset)
  end

  def encrypt(string, key = Key.default, date = Offset.default)
    @key.string = key.rjust(5, "0")
    @offset.date = date

   {
      encryption: @shift.shift_chars(string),
      key: @key.string,
      date: @offset.date
    }
  end

  def decrypt(string, key = Key.default, date = Offset.default)
    @key.string = key.rjust(5, "0")
    @offset.date = date

   {
      decryption: @shift.shift_chars(string, -1),
      key: @key.string,
      date: @offset.date
    }
  end

  def find_shift(ciphertext, date)
    cipher_last_4 = ciphertext[-4..-1].split("")
    # replace " " with "`", because "`".ord = 96, right before "a"
    end_pair = "`end".split("").zip(cipher_last_4)
    msg_shift = ciphertext.length % 4
    end_pair.rotate!(4 - msg_shift)
    end_pair.map! do |pair|
      pair[1].ord - pair[0].ord + 27
    end.map {|x| x % 27}
  end

  def find_shift_offset_pair(ciphertext, date)
    offset = Offset.new(date).generate_offsets
    find_shift(ciphertext, date).zip(offset)
  end

  def find_key(ciphertext, date)
    find_shift_offset_pair(ciphertext, date).map! do |pair|
      pair[0] += 27 if pair[0] - pair[1] < 0
      pair = pair[0] - pair[1]
    end
  end

  def stringify_key(ciphertext, date)
    keys_in_str = find_key(ciphertext, date)
      .map(&:to_s)
      .map {|n| n.rjust(2, "0")}

    key_pair = []
    keys_in_str.each_cons(2) { |n| key_pair << n }

    key_pair.map do |pair|
      if pair[0] == key_pair[1][0]
        pair[0] = key_pair[0][1]
      end

      if pair[0] == key_pair[2][0]
        pair[0] = key_pair[1][1]
      end

      smaller = pair.min
      smaller_idx = pair.index(smaller)
      until pair[0][1] == pair[1][0]
        pair[smaller_idx] = (smaller.to_i + 27).to_s
        smaller = pair[smaller_idx]
      end
    end
    result = key_pair.flatten.uniq
    result[0] + result[2] + result[3][1]
  end

  def crack(ciphertext, date = @offset.date)
    decrypt(ciphertext, stringify_key(ciphertext, date), date)
  end
end
