require './lib/key_generator'
require './lib/offsets_calculator.rb'
require './lib/enigma.rb'

# e = Enigma.new
# <<<<<<< HEAD
# encrypted_message = e.encrypt("Hello1! ..end..")
# =======
# encrypted_message = e.encrypt("Welcome12$$..end..")
# >>>>>>> c7ff9eb675c8b851a8a20779f356860a22f736cd
p encrypted_message
p e.decrypt(encrypted_message)
p e.crack(encrypted_message)
