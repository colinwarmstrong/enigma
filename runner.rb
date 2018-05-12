require './lib/key_generator'
require './lib/offsets_calculator.rb'

key_generator = KeyGenerator.new

key = key_generator.generate_random_number

p key_generator.define_rotations(key)

offsets_calculator =  OffsetsCalculator.new
p offsets_calculator.define_offsets
