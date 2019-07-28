require './test/test_helper'

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close

enigma = Enigma.new
key = "82648"
date = "240818"
encrypted = enigma.encrypt(message, key, date)
decrypted_text = enigma.decrypt(encrypted[:encryption], key, date)

writer = File.open(ARGV[1], "w")
writer.write(decrypted_text)
writer.close

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
