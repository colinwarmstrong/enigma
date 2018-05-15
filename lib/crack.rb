require './lib/enigma'

arguments = ARGV

encrypt_file = arguments[0]
crack_file = arguments[1]
date = arguments[2]

encrypted_text = File.read(encrypt_file).strip

cracked_text = File.open(crack_file, "w")

e = Enigma.new("-----", date)
crack_message = e.crack(encrypted_text)

cracked_text.write(crack_message)

puts "Created '#{crack_file}' with the cracked key #{e.key} and date #{date}"
