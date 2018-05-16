require './lib/key_generator.rb'
require './lib/enigma.rb'

arguments = ARGV

message_file_name = arguments[0]
encrypt_file_name = arguments[1]

message = File.read(message_file_name).strip
encrypt_file = File.open(encrypt_file_name, 'w')

key = KeyGenerator.new.generate_key
key_string = key.join("")
encrypted_message = Enigma.new(key).encrypt(message)

encrypt_file.write(encrypted_message)

puts "Created '#{encrypt_file_name}' with the key #{key_string} and date #{Date.today.strftime('%d%m%y')}"
