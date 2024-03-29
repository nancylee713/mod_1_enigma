require './test/test_helper'

class Decrypt
  include FileHandler

  def start
    puts "=" * 33
    puts "Welcome to Enigma!"
    puts "Please specify the file path of a text file to decrypt \n>"
    message = read(gets.chomp())

    puts "Provide a key that is 5 digit long (ex: 82648) \n>"
    key = gets.chomp()

    puts "Press r to generate today's date OR Provide a date in DDMMYY format (ex: 240818)\n>"
    date = gets.chomp()
    date == 'r' ? (date = Offset.default) : date

    enigma = Enigma.new
    decrypt_hash = enigma.decrypt(message, key, date)

    puts "Where do you want to save this decrypted file? \n>"
    output_path = gets.chomp()

    write(output_path, decrypt_hash, :decryption)
  end
end

enigma_decryptor = Decrypt.new()
enigma_decryptor.start
