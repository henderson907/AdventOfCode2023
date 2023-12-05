## Reads in the puzzle data and splits it into each line, then removes \n from each line
file_path = File.expand_path("../data.txt", __FILE__)
puzzle_input = File.read(file_path)

# Puts all seed values into an array
seeds, *maps = puzzle_input.split("\n\n")
seeds = seeds.scan(/\d+/).map(&:to_i)

maps.map! {
  map = {}

  _1.split("\n")[1..-1].each do |line|
    dest, source, length = line.split.map(&:to_i)

    range = source..(source + length)
    offset = dest - source

    map[range] = offset
  end

  map
}

seeds
  .map { |source|
    maps.reduce(source) do |source, map|
      range, offset = map.find do |range, offset|
        range.include?(source)
      end

      source += offset if range
      source
    end
  }
  .min
  .tap { puts _1 }

  # Answer = 806029445

###### PART 2 ######
