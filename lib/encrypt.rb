require './test/test_helper'

class Encrypt
  include FileHandler

  def setup
    @enigma = Enigma.new
    @key = Key.default
    @date= Offset.default
  end

  def start
    puts "=" * 33
    puts "Welcome to Enigma!"
    puts "Please specify the file path of a text file to encrypt \n>"
    message = read(gets.chomp())

    puts "Press r to generate a random key OR Provide a key that is 5 digit long (ex: 82648) \n>"
    gets.chomp() == 'r' ? (key = @key) : (key = gets.chomp())

    puts "Press r to generate today's date OR Provide a date in DDMMYY format (ex: 240818)\n>"
    gets.chomp() == 'r' ? (date = @date) : (date = gets.chomp())


    encrypt_hash = @enigma.encrypt(message, key, date)

    puts "Where do you want to save this encrypted file? \n>"
    output_path = gets.chomp()

    write_encrypt(output_path, encrypt_hash)
  end
end

enigma_encryptor = Encrypt.new()
enigma_encryptor.setup
enigma_encryptor.start
