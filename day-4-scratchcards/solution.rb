## Reads in the puzzle data and splits it into each line, then removes \n from each line
file_path = File.expand_path("../data.txt", __FILE__)
puzzle_input = File.readlines(file_path)
puzzle_input.map! { |line| line.chomp }

###### Part 1 ######

# Setting global variables used for part 1
@points = []
@winning_cards = {}
@number_of_cards = Array.new(194, 1)

puzzle_input.each_with_index do |card, index|
  winners = card.slice(10..38).split # Array of winner numbers (as a string)
  numbers_have = card.slice(42..-1).split # Array of numbers on scratchcard (as a string)
  wins = 0

  # Calculating the number of wins on each card
  numbers_have.each do |number|
    wins+= 1 if winners.include?(number)
  end

  # Calculating points total of each card and retrieving the winning card numbers and number of wins
  if wins > 0
    @points << 2**(wins - 1)
    @winning_cards["#{index + 1}"] = wins
  end
end

# Part 1
solution_1 = @points.sum
p solution_1
# Answer = 17803

###### Part 2 ######

# Iterates through each position in the array of card totals
for i in 0..193
  # Calculates the number of duplicates of each card number
  current_card_repeats = @number_of_cards[i]
  current_card_repeats.times do
    # Checks if the current card has any wins and if so, adds on the extra cards to the running totals
    if @winning_cards.has_key?("#{i + 1}")
      card_wins = @winning_cards["#{i + 1}"]
      for n in 1..card_wins
        @number_of_cards[i + n] += 1
      end
    end
  end
end

# Part 2
solution_2 = @number_of_cards.sum
p solution_2
# Answer = 5554894
