require './lib/key_generator.rb'
require './lib/enigma.rb'

arguments = ARGV

message_file_name = arguments[0]
encrypt_file_name = arguments[1]

message = File.read(message_file_name).strip
encrypt_file = File.open(encrypt_file_name, 'w')

key = KeyGenerator.new.generate_key
encrypted_message = Enigma.new.encrypt(message, key)

encrypt_file.write(encrypted_message)

puts "Created '#{encrypt_file_name}' with the key #{key} and date #{Date.today.strftime('%d%m%y')}"
