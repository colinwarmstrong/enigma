<<<<<<< HEAD
require './lib/enigma.rb'
=======
require './lib/enigma'
>>>>>>> c7ff9eb675c8b851a8a20779f356860a22f736cd

arguments = ARGV

encrypt_file = arguments[0]
crack_file = arguments[1]
date = arguments[2]

<<<<<<< HEAD
encrypted_message = File.read(encrypt_file).strip
cracked_file = File.open(decrypt_file, 'w')

e = Enigma.new(date)
cracked_message = e.crack(encrypted_message)

decrypted_file.write(decrypted_message)

puts "Created '#{cracked_file}' with the key #{key} and date #{date}"
=======
encrypted_text = File.read(encrypt_file).strip

cracked_text = File.open(crack_file, "w")

e = Enigma.new("-----", date)
crack_message = e.crack(encrypted_text)

cracked_text.write(crack_message)

puts "Created '#{crack_file}' with the cracked key #{e.key} and date #{date}"
>>>>>>> c7ff9eb675c8b851a8a20779f356860a22f736cd
