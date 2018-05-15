require './lib/key_generator'
require './lib/offsets_calculator.rb'
require './lib/enigma.rb'
require 'pry'

# key_generator = KeyGenerator.new
#
# key = key_generator.generate_random_number
#
# rotations = key_generator.define_rotations(key)
#
# offsets_calculator =  OffsetsCalculator.new
# offsets = offsets_calculator.define_offsets

e = Enigma.new
encrypted_message = e.encrypt("Hello1! ..end..")
p encrypted_message
p e.decrypt(encrypted_message)
p e.crack(encrypted_message)
