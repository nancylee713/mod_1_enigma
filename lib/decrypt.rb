require './test/test_helper'

handle = File.open(ARGV[0], "r")
encrypted = handle.read
handle.close

enigma = Enigma.new
decrypted_text = enigma.decrypt(encrypted, "82648", "240818")[:decryption]
key = enigma.decrypt(encrypted, "82648", "240818")[:key]
date = enigma.decrypt(encrypted, "82648", "240818")[:date]

writer = File.open(ARGV[1], "w")
writer.write(decrypted_text)
writer.close

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
