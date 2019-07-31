require './test/test_helper'

class Crack
  include FileHandler

  def start
    puts "=" * 33
    puts "Welcome to Enigma!"
    puts "Please specify the file path of an encrypted text file to crack \n>"
    message = read(gets.chomp())

    puts "Press r to generate today's date OR Provide a date in DDMMYY format (ex: 240818)\n>"
    input_date = gets.chomp()
    input_date == 'r' ? (input_date = Offset.default) : input_date

    enigma = Enigma.new
    crack_hash = enigma.crack(message, date = input_date)

    puts "Where do you want to save this cracked file? \n>"
    output_path = gets.chomp()

    write(output_path, crack_hash, :decryption)
  end
end

enigma_crack = Crack.new()
enigma_crack.start
