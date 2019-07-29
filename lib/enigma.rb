class Enigma

  attr_reader :char_set

  def initialize
    @char_set = ("a".."z").to_a << " "
    @key = Key.new
    @offset = Offset.new
    @shift = Shift.new(@key, @offset)
  end

  def generate_transposed_chars(string, key, date, direction)
    @key.string = key.rjust(5, "0")
    @offset.date = date
    shift = Shift.new(@key, @offset)
    temp_arr = shift.arrange_chars_by_shift(string)
    hash = {:A => 0, :B => 1, :C => 2, :D => 3}

    hash.each do |k, v|
      temp_arr[v].map! do |char|
        next char unless @char_set.include?(char)

        if direction == 'right'
          @char_set[(@char_set.index(char) + shift.generate_final_shift[k]) % 27]
        elsif direction == 'left'
          @char_set[(@char_set.index(char) - shift.generate_final_shift[k]) % 27]
        end
      end
    end
    temp_arr
  end

  def generate_encrypted_string(string, key, date)
    temp_arr = generate_transposed_chars(string, key, date, "right")
    result = []
    arr_size = temp_arr.length
    iterator = temp_arr[0].length

    iterator.times { |j| arr_size.times { |i| temp_arr[i][j] == 0 ? break : result << temp_arr[i][j] } }
    result.join
  end

  def encrypt(string, key, date)
   {
      encryption: generate_encrypted_string(string, key, date),
      key: key.rjust(5, "0"),
      date: date
    }
  end

  def generate_decrypted_string(string, key, date)
    temp_arr = generate_transposed_chars(string, key, date, "left")
    result = []
    arr_size = temp_arr.length
    iterator = temp_arr[0].length

    iterator.times { |j| arr_size.times { |i| temp_arr[i][j] == 0 ? break : result << temp_arr[i][j] } }
    result.join
  end

  def decrypt(string, key, date)
   {
      decryption: generate_decrypted_string(string, key, date),
      key: key.rjust(5, "0"),
      date: date
    }
  end

  def find_shift(ciphertext, date)
    cipher_last_4 = ciphertext[-4..-1].split("")
    # replace " " with "`", because "`".ord = 96, right before "a"
    end_pair = "`end".split("").zip(cipher_last_4)
    msg_shift = ciphertext.length % 4
    end_pair.rotate!(4 - msg_shift)
    shift_ord = end_pair.map! { |pair| pair[1].ord - pair[0].ord }
  end

  def find_shift_offset_pair(ciphertext, date)
    shift_ord = find_shift(ciphertext, date)
    offset = Offset.new(date).generate_offsets
    shift_offset_pair = shift_ord.zip(offset)
  end

  def find_key(ciphertext, date)
    find_shift_offset_pair(ciphertext, date).map! do |pair|
      pair[0] += 27 if pair[0] - pair[1] < 0
      pair = pair[0] - pair[1]
    end
  end


  # def crack(ciphertext, date = @offset.date)
  #
  #
  # end
end
