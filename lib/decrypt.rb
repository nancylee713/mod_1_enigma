require './test/test_helper'

handle = File.open(ARGV[0], "r")
encrypted = handle.read
handle.close

enigma = Enigma.new
key = "82648"
date = "240818"
decrypted_text = enigma.decrypt(encrypted, key, date)[:decryption]

writer = File.open(ARGV[1], "w")
writer.write(decrypted_text)
writer.close

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
