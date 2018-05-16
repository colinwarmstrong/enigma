require './lib/key_generator'
require './lib/offsets_calculator.rb'
require './lib/enigma.rb'

e = Enigma.new

encrypted_message1 = e.encrypt("Hello1! ..end..")
encrypted_message2 = e.encrypt("Welcome12$$..end..")

p encrypted_message1
p e.decrypt(encrypted_message1)
p e.crack(encrypted_message1)

p encrypted_message2
p e.decrypt(encrypted_message2)
p e.crack(encrypted_message2)
