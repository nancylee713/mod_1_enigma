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

  def encrypt(string, key=@key.string, date=@offset.date)
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

  def decrypt(string, key=@key.string, date=@offset.date)
   {
      decryption: generate_decrypted_string(string, key, date),
      key: key.rjust(5, "0"),
      date: date
    }
  end

  def crack(message, date=@offset.date)
    hint = " end"
    tag = message[-4..-1]
    hint_ord = hint.split("").map(&:ord)
    hint_ord[0] = 97
    tag_ord = tag.split("").map(&:ord)

    shift_by_letter = hint_ord.zip(tag_ord).map {|x| x[1] - x[0]}
    offset = @offset.generate_offsets
    key = shift_by_letter.zip(offset).map{ |e| e[0] - e[1]}
    # binding.pry
  end
end
