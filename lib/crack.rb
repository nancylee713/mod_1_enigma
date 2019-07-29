require './test/test_helper'

handle = File.open(ARGV[0], "r")
encrypted_end = handle.read.chomp
handle.close

enigma = Enigma.new
date = ARGV[2]
# key = "82648" (from './lib/encrypt')
decrypted_text = enigma.crack(encrypted_end, date)[:decryption]
cracked_key = enigma.crack(encrypted_end, date)[:key]

writer = File.open(ARGV[1], "w")
writer.write(decrypted_text)
writer.close

puts "Created #{ARGV[1]} with the cracked key #{cracked_key} and date #{date}"
