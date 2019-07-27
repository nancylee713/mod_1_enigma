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
        next if char == 0
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
    result = ""
    arr_size = temp_arr.length
    iterator = temp_arr[0].length

    iterator.times { |j| arr_size.times { |i| temp_arr[i][j] == nil ? break : result += temp_arr[i][j] } }
    result
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
    result = ""
    arr_size = temp_arr.length
    iterator = temp_arr[0].length

    iterator.times { |j| arr_size.times { |i| temp_arr[i][j] == nil ? break : result += temp_arr[i][j] } }
    result
  end

  def decrypt(string, key, date)
   {
      decryption: generate_decrypted_string(string, key, date),
      key: key.rjust(5, "0"),
      date: date
    }
  end
end
