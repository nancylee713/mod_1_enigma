require './modules/shift_helper'

class Enigma
  include ShiftHelper

  attr_reader :key, :offset

  def initialize
    @key = Key.new
    @offset = Offset.new
    @shift = Shift.new(@key, @offset)
  end

  def encrypt(string, key = Key.default, date = Offset.default)
    @key.string = key.rjust(5, "0")
    @offset.date = date
    shift_size = @shift.generate_final_shift
   {
      encryption: @shift.shift_chars(string, shift_size),
      key: @key.string,
      date: @offset.date
    }
  end

  def decrypt(string, key = Key.default, date = Offset.default)
    @key.string = key.rjust(5, "0")
    @offset.date = date
    shift_size = @shift.generate_final_shift
   {
      decryption: @shift.shift_chars(string, shift_size, -1),
      key: @key.string,
      date: @offset.date
    }
  end

  def crack(ciphertext, date = Offset.default)
    shift_size = generate_hash_with_four_keys(find_shift(ciphertext, date))

    {
       decryption: @shift.shift_chars(ciphertext, shift_size, -1),
       shift_size: shift_size,
       date: @offset.date
     }
  end
end
