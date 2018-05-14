require './lib/key_generator.rb'
require './lib/enigma.rb'

arguments = ARGV

message_file = arguments[0]
encrypt_file = arguments[1]

message = File.read(message_file).strip

encrypted_file = File.open(encrypt_file, 'w')

key = KeyGenerator.new.generate_key
encrypted_message = Enigma.new(key).encrypt(message)

encrypted_file.write(encrypted_message)

puts "Created '#{encrypt_file}' with the key #{key} and date #{Date.today.strftime('%d%m%y')}"
