require 'pry'

# Reading in the input data and turning it into more helpful format
file_path = File.expand_path("../data.txt", __FILE__)
lines = File.readlines(file_path).map(&:chomp)

# Creating blank arrays to hold our maps
seed_to_soil = []
soil_to_fertilizer = []
fertilizer_to_water = []
water_to_light = []
light_to_temperature = []
temperature_to_humidity = []
humidity_to_location = []

# setting a variable to hold current map
current_map = nil

# SPlitting up the input data into each of the maps
lines.each do |line|
  next if line.empty?
  # Setting the name of the map using the line given in the puzzle input
  if line.include?('map')
    current_map = "#{line.split(' ')[0].gsub('-', '_')}"
    next
  end

  # Pushing the data for the map into the current map
  if current_map
    eval("#{current_map} << line")
  end
end

# Rewriting the data in each map to be more usable
def fill_ranges(lines)
  result = {}
  lines.each do |line|
    destination, source, range = line.split(' ').map(&:to_i)

    result[source...(source + range)] = destination...(destination + range)
  end
  result
end

# EValuating the map to give the destination from the source
def find_destination(ranges, n)
  ranges.each do |source, destination|
    if source.include?(n)
      return destination.min + (n - source.min)
    end
  end
  n
end

# Passing each map to the fill ranges method to rewrite the data
seed_to_soil_ranges = fill_ranges(seed_to_soil)
soil_to_fertilizer_ranges = fill_ranges(soil_to_fertilizer)
fertilizer_to_water_ranges = fill_ranges(fertilizer_to_water)
water_to_light_ranges = fill_ranges(water_to_light)
light_to_temperature_ranges = fill_ranges(light_to_temperature)
temperature_to_humidity_ranges = fill_ranges(temperature_to_humidity)
humidity_to_location_ranges = fill_ranges(humidity_to_location)

# Grabbing the seeds from the puzzle input
@seeds = lines.first.gsub('seeds: ', '').split(' ').map(&:to_i)
locations = []

# Passing each seed through all the maps in turn to get the location
@seeds.each do |seed|
  location = find_destination(seed_to_soil_ranges, seed)
  location = find_destination(soil_to_fertilizer_ranges, location)
  location = find_destination(fertilizer_to_water_ranges, location)
  location = find_destination(water_to_light_ranges, location)
  location = find_destination(light_to_temperature_ranges, location)
  location = find_destination(temperature_to_humidity_ranges, location)
  location = find_destination(humidity_to_location_ranges, location)
  locations << location
end

# Part 1
puts locations.min
# Answer = 806029445

###### PART 2 ######

seed_ranges = []
locations = []

# Setting seed ranges for part 2
seed_numbers = @seeds.each.with_index do |seed, i|
  if i % 2 == 0
    seed_ranges << (seed..(seed + @seeds[i + 1] - 1))
  end
end

# Returns nil if there is no overlap between source range and destinaion range
# Otherwise returns the smallest possible range (biggest_minimum..smallest_maximum)
def range_intersection(range1, range2)
  return nil if (range1.max < range2.begin || range2.max < range1.begin)
  [range1.begin, range2.begin].max..[range1.max, range2.max].min
end

# Evaluating the ranges in the maps, making use of the range_intersection method to cut down on
# the computational power required as well as iterating over ranges rather than individual numbers
def find_destination_ranges(source_ranges, destination_ranges)
  result = []
  # Iterates through the source ranges (min..max)
  source_ranges.uniq.each do |source_range|
    # Iterates through the presented map but via a range!
    destination_ranges.each.with_index do |(source_range_temp, destination_range), i|
      # If there is an overlap between the ranges...
      if (intersection = range_intersection(source_range, source_range_temp))
        result << ((intersection.min - source_range_temp.min + destination_range.min)..(intersection.max - source_range_temp.max + destination_range.max))
        # If the source range is exactly equal to the overlap...
        if intersection.size == source_range.size
          break
        else
          # If the overlap stops before the end of the source range...
          if intersection.max < source_range.max
            source_range = ((intersection.max + 1)..source_range.max)
          else
            source_range = ((source_range.min)..(intersection.min - 1))
          end
        end
      elsif i == destination_ranges.size - 1
        result << source_range
      end
    end
  end
  result
end

results = []

# Passing each seed range through all the maps in turn to get the location
soil_ranges = find_destination_ranges(seed_ranges, seed_to_soil_ranges)
fertilizer_ranges = find_destination_ranges(soil_ranges, soil_to_fertilizer_ranges)
water_ranges = find_destination_ranges(fertilizer_ranges, fertilizer_to_water_ranges)
light_ranges = find_destination_ranges(water_ranges, water_to_light_ranges)
temperature_ranges = find_destination_ranges(light_ranges, light_to_temperature_ranges)
humidity_ranges = find_destination_ranges(temperature_ranges, temperature_to_humidity_ranges)
location_ranges = find_destination_ranges(humidity_ranges, humidity_to_location_ranges)


# Part 2
puts location_ranges.map(&:min).min
# Answer = 59370572
