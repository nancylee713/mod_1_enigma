require './test/test_helper'

class Decrypt
  include FileHandler

  def setup
    @enigma = Enigma.new
    @key = Key.default
    @date= Offset.default
  end

  def start
    puts "=" * 33
    puts "Welcome to Enigma!"
    puts "Please specify the file path of a text file to decrypt \n>"
    message = read(gets.chomp())

    puts "Provide a key that is 5 digit long (ex: 82648) \n>"
    key = gets.chomp()

    puts "Press r to generate today's date OR Provide a date in DDMMYY format (ex: 240818)\n>"
    gets.chomp() == 'r' ? (date = @date) : (date = gets.chomp())

    decrypt_hash = @enigma.decrypt(message, key, date)

    puts "Where do you want to save this decrypted file? \n>"
    output_path = gets.chomp()

    write_decrypt(output_path, decrypt_hash)
  end
end

enigma_decryptor = Decrypt.new()
enigma_decryptor.setup
enigma_decryptor.start
