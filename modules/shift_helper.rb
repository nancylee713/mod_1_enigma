module ShiftHelper

  def generate_hash_with_four_keys(arr)
    chars = [:A, :B, :C, :D]
    Hash[chars.zip(arr)]
  end
  
  def find_shift(ciphertext, date)
    cipher_last_4 = ciphertext[-4..-1].split("")
    end_pair = "`end".split("").zip(cipher_last_4)
    msg_shift = ciphertext.length % 4
    end_pair.rotate!(4 - msg_shift)
    end_pair.map! do |pair|
      pair[1].ord - pair[0].ord + 27
    end.map {|x| x % 27}
  end

  # *** ATTEMPT at finding an exact key ***
  # def find_shift_offset_pair(ciphertext, date)
  #   offset = Offset.new(date).generate_offsets
  #   find_shift(ciphertext, date).zip(offset)
  # end

  # def find_key_pair(ciphertext, date)
  #   key_pair = []
  #   find_shift_offset_pair(ciphertext, date).map! do |pair|
  #     pair[0] += 27 if pair[0] - pair[1] < 0
  #     pair = pair[0] - pair[1]
  #   end.map(&:to_s)
  #     .map {|n| n.rjust(2, "0")}
  #     .each_cons(2) { |n| key_pair << n }
  #   key_pair
  # end

  # def stringify_key(ciphertext, date)
  #   key_pair = find_key_pair(ciphertext, date)
  #   key_pair.map do |pair|
  #     if pair[0] == key_pair[1][0]
  #       pair[0] = key_pair[0][1]
  #     elsif pair[0] == key_pair[2][0]
  #       pair[0] = key_pair[1][1]
  #     end
  #     smaller = pair.min
  #     smaller_idx = pair.index(smaller)
  #     until pair[0][1] == pair[1][0]
  #       pair[smaller_idx] = (smaller.to_i + 27).to_s
  #       smaller = pair[smaller_idx]
  #     end
  #   end
  #   result = key_pair.flatten.uniq
  #   result[0] + result[2] + result[3][1]
  # end
end
