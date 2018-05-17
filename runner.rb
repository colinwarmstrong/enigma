require './lib/key_generator'
require './lib/offsets_calculator.rb'
require './lib/enigma.rb'

e = Enigma.new
key = KeyGenerator.new.generate_key

encrypted_message1 = e.encrypt('Hello1! ..end..', key)
encrypted_message2 = e.encrypt('Welcome12$$..end..', key)

p encrypted_message1
p e.decrypt(encrypted_message1, key)
p e.crack(encrypted_message1)

p encrypted_message2
p e.decrypt(encrypted_message2, key)
p e.crack(encrypted_message2)
