# Reading in the input data and turning it into more helpful format
file_path = File.expand_path("../data.txt", __FILE__)
lines = File.readlines(file_path).map(&:chomp)

###### PART 1 ######
@winning_counts = []

# Such little data it wasn't worth putting it into an array via the machine
races = { "49": 356, "87": 1378, "78": 1502, "95": 1882 }

# Method that takes the length of the race and the record
# Calculates distance travelled for each second held possible and if it exceeds the record, adds 1 to the count
# Then pushes the count into the pre-created array
def no_of_wins(time, record)
  count = 0
  for i in 1..time.to_i
    time_remaining = time -i
    speed = i
    # Speed = Distance / Time => Distance = Speed * Time
    distance = speed * time_remaining
    if distance > record
      count += 1
    end
  end
  @winning_counts << count
end

# Could iterate through the hash but it barely makes a difference to just write 4 method calls
no_of_wins(49, 356)
no_of_wins(87, 1378)
no_of_wins(78, 1502)
no_of_wins(95, 1882)

# Multiplies all the number of ways to win together
p @winning_counts.inject(:*)
# Answer = 503424


###### PART 2 ######
# 49877895 => 356137815021882

# Gives new value to the method
no_of_wins(49877895, 356137815021882)

# Takes last element of winning_counts array as this was the final output
p @winning_counts[-1]
# Answer = 32607562
