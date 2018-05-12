require './lib/key_generator'
require './lib/offsets_calculator.rb'
require './lib/encryptor.rb'
require './lib/decryptor.rb'
require './lib/enigma.rb'
require 'pry'

key_generator = KeyGenerator.new

key = key_generator.generate_random_number

rotations = key_generator.define_rotations(key)

offsets_calculator =  OffsetsCalculator.new
offsets = offsets_calculator.define_offsets

e = Enigma.new("Hello1!", [2, 3, 4, 5], [2, 3, 4, 5])
encrypted_message = e.encrypt
p encrypted_message
p e.decrypt(encrypted_message)
