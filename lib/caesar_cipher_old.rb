# name is a string
# shift is a integer
# method returns the encrypted string
# algorithm will run through each character and determine if
# lower case, upper case, or something else
# for lower and upper case the ordinal value will decrease by shift
# otherwise the ordinal value will remain the same, ie. white space and punctuation
# algo handles both positive and negative shifts
# assumes shift is between -25 and 25

def caesar_cipher(name,shift)

  return_value = ""
  lower_case_min = 'a'.ord
  lower_case_max = 'z'.ord
  upper_case_min = 'A'.ord
  upper_case_max = 'Z'.ord  

  name.scan /./ do |i|

    ord = i.ord
    # let's do lowercase first
    if (lower_case_min..lower_case_max).include?(ord)
      new_value = ord + shift
      if new_value < lower_case_min
        new_value = lower_case_max - (lower_case_min - new_value) + 1
      elsif new_value > lower_case_max
      	new_value = lower_case_min + (new_value - lower_case_max) - 1
      end
      return_value += new_value.chr
    elsif (upper_case_min..upper_case_max).include?(ord)
      new_value = ord + shift
      if new_value < upper_case_min
        new_value = upper_case_max - (upper_case_min - new_value) + 1
      elsif new_value > upper_case_max
      	new_value = upper_case_min + (new_value - upper_case_max) - 1
      end
      return_value += new_value.chr
    else
      return_value += ord.chr
    end

    #puts ord
    #puts new_value # not valid for punctuation

  end
  return return_value
end


# i am thinking of a solution that adds the increment value from an array that
# takes the wrap-around into effect
# ie increment = [1, 1, 1, 1, ..... 1, -25] for an increment of 1
# this increment array needs to be generated each time the function is called.
# note that this method only works for a positive number, a separate method is required
# for the decipher because the increment array needs to be regenerated. The code below
# could be modified to handle both +number (cipher) and -number (decipher), however that
# was not the initial problem statement.

def caesar_cipher3(string,number)
   # if I had a C-stype for-loop I could have merged the following 2 lines into 1 line of code.
   # However I didn't find a for-loop that allows me to intialize the increment array
   #increment = []
   #26.times { |i| (i<(26-(number%26))) ? increment << (number%26) : increment << -(26-(number%26))}

   increment = Array.new(26){ |i| (i<(26-(number%26))) ? (number%26) : -(26-(number%26)) }
   # increment array should change based on number
   # for number = 1 increment should be generated as such
   #increment = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
   #             1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
   #             1, 1, 1, 1, 1, -25]
   # for number = 2 increment should be generated as such
   #increment = [2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
   #             2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
   #             2, 2, 2, 2, -24, -24]	
   # note that parens around increment are important
   string.gsub(/[a-zA-Z]/) {|s| (s.ord >= 97) ? s.ord.+(increment[(s.ord-97)]).chr :
                                                s.ord.+(increment[(s.ord-65)]).chr }
end


def caesar_cipher2(string,number)
    string.gsub(/[a-zA-Z]/) {|s| s.ord.+(number).chr }
end

puts caesar_cipher("az AZ!",2)
puts caesar_cipher("What a string!",5)
puts caesar_cipher2("What a string!",5)
puts caesar_cipher2('\mfy f xywnsl!',-5)
puts caesar_cipher("az AZ!",-2)

puts caesar_cipher2("What a string!",5)
puts caesar_cipher3("What a string!",5)

puts -5
puts -5%26

# problem above. i need for a -> 0 and A -> 0 and z -> 25 and Z -> 25
puts "a".ord
puts "a".ord%26
puts "A".ord
puts "A".ord%26