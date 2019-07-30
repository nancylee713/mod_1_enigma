require './test/test_helper'

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close

enigma = Enigma.new
key = "82648"
date = "240818"
encrypted_text = enigma.encrypt(message, key, date)[:encryption]
encrypted_key = enigma.encrypt(message, key, date)[:key]
encrypted_date = enigma.encrypt(message, key, date)[:date]

writer = File.open(ARGV[1], "w")
writer.write(encrypted_text)
writer.close

puts "Created #{ARGV[1]} with the key #{encrypted_key} and date #{encrypted_date}"
