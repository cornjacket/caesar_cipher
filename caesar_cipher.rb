# The solution below was inspired by thurst306's solution which cleverly used
# the gsub method in one line, 
# https://github.com/thurst306/the_odin_projects/blob/master/caesar_cipher.rb
# However that solution was incomplete as it encrypted spaces and punctuation
# as well as did not perform wrapping for alphabet characters.
# This solution encrypts in 2 steps.
# First, the increment array is created based on the 'number' of shifts. The
# increment array serves as a function that returns the ordinal value that is
# added to the character to be encrypted. Instead of adding the shift and then
# modding 26 to resolve wrap around, the increment array returns the correct 
# value to add to the character to be encrypted in one step already taking wrap
# around into effect.
# for number = 1, increment is generated as
# increment = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
#              1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
#              1, 1, 1, 1, 1, -25]
# for number = 2, increment is generated as
# increment = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
#              2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
#              2, 2, 2, 2, -24, -24]
# mod26 is used in case the user enters a number larger than 25. As it turns out
# the modulus' behavior properly handles the case where the user enters a negative
# number for the encryption. ie. -1 mod 26 = 25
# for number = -1, increment is generated as
# increment = [25, -1, -1, -1, -1, -1, -1, -1, -1, -1,
#             -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
#             -1, -1, -1, -1, -1, -1]
# The second step involves doing a gsub on the string replacing any lower or upper
# alphabet characters but leaving all other characters (ie. spaces, numbers, punc-
# tuation) untouched. The block handles lower case and upper case separately by
# normalizing the character in order to lookup the increment value which is uses
# to encrypt.

def caesar_cipher(string,number)
# string is a String
# number is an Integer, numbers out of bounds are wrapped
# method returns the encrypted string
  increment = Array.new(26){ |i| (i<(26-(number%26))) ? (number%26) : -(26-(number%26)) }
  string.gsub(/[a-zA-Z]/) {|s| (s.ord >= 97) ? s.ord.+(increment[(s.ord-97)]).chr :
                                               s.ord.+(increment[(s.ord-65)]).chr }
end

puts caesar_cipher("What a string!",5)
puts caesar_cipher("Bmfy f xywnsl!",-5)