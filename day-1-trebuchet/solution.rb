## Reads in the puzzle data and splits it into each line
file_path = File.expand_path("../data.txt", __FILE__)
puzzle_input = File.read(file_path).split

###### PART 1 #####

# Takes puzzle input and blank "values" array
# Removes any non-numbers and puts the digits in an array
# Takes the first digit, multiplies it by 10 and adds on the last digit
# Shuttles this vaue into the "values" array
def number_calc(input, values)
  input.each do |line|
    numbers_string = line.gsub(/\D/, "")
    numbers_array = numbers_string.split("")
    values << (((numbers_array[0].to_i) *10) + (numbers_array[-1].to_i))
  end
end

# Sets a blank array and passes it, plus the puzzle input to number_calc method
values = []
number_calc(puzzle_input, values)

# Adds up all the values to retrieve the answer
solution_1 = values.sum
p solution_1
# Answer = 54632


###### PART 2 ######

# Unconventional way of solving it but as some letters are shared by multiple typed out numbers, I
# decided to just put in the number without removing any potentially shared letters, given they
# will get removed in the number_calc method
# i.e. oneight = 18, != 1ight, != on8
puzzle_input.map! { |line| line.gsub("one", "one1one") }
puzzle_input.map! { |line| line.gsub("two", "two2two") }
puzzle_input.map! { |line| line.gsub("three", "three3three") }
puzzle_input.map! { |line| line.gsub("four", "four4four") }
puzzle_input.map! { |line| line.gsub("five", "five5five") }
puzzle_input.map! { |line| line.gsub("six", "six6six") }
puzzle_input.map! { |line| line.gsub("seven", "seven7seven") }
puzzle_input.map! { |line| line.gsub("eight", "eight8eight") }
puzzle_input.map! { |line| line.gsub("nine", "nine9nine") }

# Resets the values array to be blank
# Passes the values array and the new puzzle input into the number_calc method
values = []
number_calc(puzzle_input, values)

# Adds up all the values to retrieve the answer
solution_2 = values.sum
p solution_2
# Answer = 54019
