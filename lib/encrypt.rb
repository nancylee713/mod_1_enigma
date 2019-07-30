require './test/test_helper'

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close

enigma = Enigma.new

encrypted_text = enigma.encrypt(message, "82648", "240818")[:encryption]
key = enigma.encrypt(message, "82648", "240818")[:key]
date = enigma.encrypt(message, "82648", "240818")[:date]

writer = File.open(ARGV[1], "w")
writer.write(encrypted_text)
writer.close

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
