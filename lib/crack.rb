require './lib/enigma.rb'

arguments = ARGV

encrypt_file_name = arguments[0]
crack_file_name = arguments[1]
date_string = arguments[2]

encrypted_message = File.read(encrypt_file_name).strip
crack_file = File.open(crack_file_name, "w")

date = date_string.to_i

e = Enigma.new([], date)
cracked_message = e.crack(encrypted_message)
key = e.convert_rotations_to_key(encrypted_message)

crack_file.write(cracked_message)

puts "Created '#{crack_file_name}' with the cracked key #{key} and date #{date_string}"
