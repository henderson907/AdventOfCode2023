## Reads in the puzzle data and splits it into each line, then removes \n from each line
file_path = File.expand_path("../data.txt", __FILE__)
puzzle_input = File.readlines(file_path)
puzzle_input.map! { |line| line.chomp }

###### PART 1 ######
# Matrix needs to be 140 x 140

# Setting global variables for part 1
@og_matrix = []
@adapted_matrix = []
@possible_values = []
@possible_totals = []

# Put the input into a usable matrix
# For each individual digit, I replaced it with the actual overall number it was part of and then
# removed replicates later on in the process
puzzle_input.each do |line|
  adapted_line = line.split("")
  i = 0
  while i < 140
    # In the case that it is the final row element
    if i == 139
      i +=1
    # In the case that it is the penultimate row element
    elsif i == 138
      # Checking if it is a 2 digit number or not
      if adapted_line[i].match?(/\d/) == true && adapted_line[i+1].match?(/\d/) == true
        total_val = "#{(adapted_line[i].to_i*10)+(adapted_line[i+1].to_i)}"
        adapted_line[i] = total_val
        adapted_line[i+1] = total_val
        i += 2
      else
        i += 1
      end
    # Any other row element
    else
      # Checking if it is a 3 digit, 2 digit or single digit number
      if adapted_line[i].match?(/\d/) == true && adapted_line[i+1].match?(/\d/) == true && adapted_line[i+2].match?(/\d/) == true # is a digit
        total_val = "#{(adapted_line[i].to_i*100)+(adapted_line[i+1].to_i*10)+(adapted_line[i+2].to_i)}"
        adapted_line[i] = total_val
        adapted_line[i+1] = total_val
        adapted_line[i+2] = total_val
        i += 3
      elsif adapted_line[i].match?(/\d/) == true && adapted_line[i+1].match?(/\d/) == true
        total_val = "#{(adapted_line[i].to_i*10)+(adapted_line[i+1].to_i)}"
        adapted_line[i] = total_val
        adapted_line[i+1] = total_val
        i += 2
      else
        i += 1
      end
    end
  end
  # Shuttling the adapted lines into an array to create an adapted matrix
  @adapted_matrix << adapted_line
end

# The matrix is 140 x 140
for row in 0..139
  @possible_row = []
  for col in 0..139
    if @adapted_matrix[row][col].match?(/\d/) == true # If the value is a digit using Regex
      # In the case of [1,1]
      if row == 0 && col == 0
        if @adapted_matrix[row][col+1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [1,140]
      elsif row == 0 && col == 139
        if @adapted_matrix[row][col-1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [140,1]
      elsif row == 139 && col == 0
        if @adapted_matrix[row-1][col].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [140,140]
      elsif row == 139 && col == 139
        if @adapted_matrix[row-1][col-1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [1,j]
      elsif row == 0
        if @adapted_matrix[row][col-1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [140, j]
      elsif row == 139
        if @adapted_matrix[row-1][col-1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [i, 0]
      elsif col == 0
        if @adapted_matrix[row-1][col].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # In the case of [i, 140]
      elsif col == 139
        if @adapted_matrix[row-1][col-1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      # All other cases / cases not on an edge or in a corner
      else
        if @adapted_matrix[row-1][col-1].match?(/[^.\d]/) == true # If the value is a symbol
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row-1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col-1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        elsif @adapted_matrix[row+1][col+1].match?(/[^.\d]/) == true
          @possible_row << @adapted_matrix[row][col]
        end
      end
    end
  end

  @adjusted_row = []
  @max_index = @possible_row.length - 1
  # Removing duplicate numbers from row number calculations
  # IMPORTANT! It is done this way rather than use .uniq! because some rows may have the same numbers used
  # on more than one ocassion, and so you cannot just remove all duplicates, only NEIGHBOURING duplicates!
  @possible_row.each_with_index do |el, index|
    unless index == @max_index
      if el == @possible_row[index + 1]
        el = 0
      end
    end
    @adjusted_row << el.to_i
  end
  # We don't actually need @possible_values, it just felt weird not storing the actual data somewhere
  @possible_values << @adjusted_row
  # This adds up the values for each row and puts them into an array
  @possible_totals << @adjusted_row.sum
end

# Part 1
solution_1 =  @possible_totals.sum
p solution_1
# Answer = 540025

###### PART 2 ######

@gear_positions = []
@gear_ratios = []

# Finds the coordinates / position of each gear and shuttles them in array format into an array of all gear positions
@adapted_matrix.each_with_index do |line, i|
  line.each_with_index do |element, j|
    if element == "*"
      @gear_positions << [i,j]
    end
  end
end

@gear_positions.each do |gear|
  i = gear[0]
  j = gear[1]
  gear_vals = []

  # Checks each adjacent position to the gear for numbers and if so, shoots them into an array
  # containing all adjacent numbers to said gear
  (@adapted_matrix[i-1][j-1].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i-1][j-1]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i-1][j].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i-1][j]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i-1][j+1].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i-1][j+1]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i][j-1].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i][j-1]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i][j+1].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i][j+1]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i+1][j-1].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i+1][j-1]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i+1][j].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i+1][j]).to_i) : (gear_vals << 1)
  (@adapted_matrix[i+1][j+1].match?(/\d/) == true) ? (gear_vals << (@adapted_matrix[i+1][j+1]).to_i) : (gear_vals << 1)

  # Removes any duplicates of the data
  gear_vals.uniq!

  # Checks that the gears have exactly 2 adjacent numbers (remember, we shuttled in 1 for non-numbers so our arrays
  # look like this [1, x, y]), and if so, multiplies them together and sends it into an array containing
  # all the gear ratios
  if gear_vals.length == 3
    @gear_ratios << gear_vals[0] * gear_vals[1] * gear_vals[2]
  end
end

# Part 2
solution_2 = @gear_ratios.sum
p solution_2
# Answer = 84584891
