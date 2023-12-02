## Reads in the puzzle data and splits it into each line
file_path = File.expand_path("../data.txt", __FILE__)
puzzle_input = File.readlines(file_path)

###### Part 1 ######

possible_ids = []
cube_powers = []

# Removes game number from input
puzzle_input.map! { |line| line.sub(/Game\s\d+:\s/, '') }
# Removes \n from each line
puzzle_input.map! { |line| line.chomp }

# Setting global variables of how many coloured cubes are in the bag
@max_red = 12
@max_green = 13
@max_blue = 14

# Method to check if a game is possible or not
# Also rewrites minimum cubes required if the current number is lower than the one given
def colour_checker(colour, number)
  case colour
  when "red"
    @possible = false if number > @max_red
    @min_red = number if number > @min_red
  when "green"
    @possible = false if number > @max_green
    @min_green = number if number > @min_green
  when "blue"
    @possible = false if number > @max_blue
    @min_blue = number if number > @min_blue
  end
end

puzzle_input.each_with_index do |game, index|
  # Resetting variables needed to track game stats
  @possible = true
  @min_red = 0
  @min_green = 0
  @min_blue = 0

  # Uses nested loops to arrange data into more accessible format
  rounds = game.split(/;/)
  rounds.each do |round|
    new_rounds = round.split(/,/)
    new_rounds.each do |ind_round|
      number = ind_round.scan(/\d+/).join.to_i
      colour = ind_round.scan(/[a-zA-Z]+/).join

      colour_checker(colour, number)
    end
  end

  # Shuttling the "power" into the array for part 2
  cube_powers << (@min_red * @min_green * @min_blue)

  # Checking if the game is possible and if so, shuttling the game number into the array for part 1
  if @possible == true
    possible_ids << index + 1
  else
    possible_ids << 0
  end
end

# Adding up the values of all the possible ids
solution_1 = possible_ids.sum
p solution_1
# Answer = 2285

# Adding up the values of all the cube powers
solution_2 = cube_powers.sum
p solution_2
# Answer = 77021
