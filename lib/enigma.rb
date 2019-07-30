require './modules/revert'

class Enigma
  include Revert
  
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
end
