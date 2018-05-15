require './lib/key_generator'
require './lib/offsets_calculator.rb'
require './lib/enigma.rb'

e = Enigma.new
encrypted_message = e.encrypt("Welcome12$$..end..")
p encrypted_message
p e.decrypt(encrypted_message)
p e.crack(encrypted_message)
