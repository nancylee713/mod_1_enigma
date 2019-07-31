require './test/test_helper'

class Encrypt
  include FileHandler

  def setup
    @enigma = Enigma.new
  end

  def start
    puts "=" * 33
    puts "Welcome to Enigma!"
    puts "Please specify the file path of a text file to encrypt \n>"
    message = read(gets.chomp())

    puts "Provide a key that is 5 digit long (ex: 82648) \n>"
    key = gets.chomp()

    puts "Provide a date in DDMMYY format (ex: 240818)\n>"
    date = gets.chomp()

    encrypt_hash = @enigma.encrypt(message, key, date)

    puts "Where do you want to save this encrypted file? \n>"
    output_path = gets.chomp()

    write_encrypt(output_path, encrypt_hash)
  end
end

enigma_encryptor = Encrypt.new()
enigma_encryptor.setup
enigma_encryptor.start
