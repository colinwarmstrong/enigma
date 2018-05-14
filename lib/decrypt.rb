require './lib/enigma.rb'

arguments = ARGV

encrypt_file = arguments[0]
decrypt_file = arguments[1]
key = arguments[2]
date = arguments[3]

encrypted_message = File.read(encrypt_file).strip
decrypted_file = File.open(decrypt_file, 'w')

e = Enigma.new(key, date)
decrypted_message = e.decrypt(encrypted_message)

decrypted_file.write(decrypted_message)

puts "Created '#{decrypt_file}' with the key #{key} and date #{date}"
