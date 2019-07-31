require './test/test_helper'

class Encrypt
  include FileHandler

  def start
    puts "=" * 33
    puts "Welcome to Enigma!"
    puts "Please specify the file path of a text file to encrypt \n>"
    message = read(gets.chomp())

    puts "Press r to generate a random key OR Provide a key that is 5 digit long (ex: 82648) \n>"
    key = gets.chomp()
    key == 'r' ? (key = Key.default) : key

    puts "Press r to generate today's date OR Provide a date in DDMMYY format (ex: 240818)\n>"
    date = gets.chomp()
    date == 'r' ? (date = Offset.default) : date

    enigma = Enigma.new
    encrypt_hash = enigma.encrypt(message, key, date)

    puts "Where do you want to save this encrypted file? \n>"
    output_path = gets.chomp()

    write_encrypt(output_path, encrypt_hash)
  end
end

enigma_encryptor = Encrypt.new()
enigma_encryptor.start
