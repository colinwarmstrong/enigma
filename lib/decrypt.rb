require './lib/enigma.rb'

arguments = ARGV

encrypt_file_name = arguments[0]
decrypt_file_name = arguments[1]
key_string = arguments[2]
date_string = arguments[3]

encrypted_message = File.read(encrypt_file_name).strip
decrypt_file = File.open(decrypt_file_name, 'w')

key = key_string.to_i.digits.reverse
date = date_string.to_i

e = Enigma.new(key, date)
decrypted_message = e.decrypt(encrypted_message)

decrypt_file.write(decrypted_message)

puts "Created '#{decrypt_file_name}' with the key #{key_string} and date #{date}"
