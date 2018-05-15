require './lib/enigma.rb'

arguments = ARGV

encrypt_file = arguments[0]
crack_file = arguments[1]
date = arguments[2]

encrypted_message = File.read(encrypt_file).strip
cracked_file = File.open(decrypt_file, 'w')

e = Enigma.new(date)
cracked_message = e.crack(encrypted_message)

decrypted_file.write(decrypted_message)

puts "Created '#{cracked_file}' with the key #{key} and date #{date}"
