require_relative 'config/environment.rb'
require_relative 'bin/game.rb'

Game.clear_screen


# def create_map(width, height)
#   floor = ("-"*width) + ("|" + (" "*(width - 2)) + "|\n") *(height) + ("-"*width).to_s    # could create a constructor method below that uses the instance height to generate a room with the appropriate number of '-', ' ', and '|'
#   number_of_walls = rand(50..70)
#   number_of_walls.times do
#     wall_location = (rand(2..(width - 2)) + width)
#     height.times do
#       if rand(0..100) > 60
#         floor[wall_location] = " "
#       else
#         floor[wall_location] = "x"
#       end
#       wall_location += (width + 1)
#     end
#   end
#   return floor
# end
max_width = `tput cols`.to_i
max_height = (`tput lines`.to_i - 5)

# def create_map(max_width, max_height, runners, rooms)
#   # Create room string
#   floor = ("#"*max_width) + ("#" + ("#"*(max_width - 2)) + "#\n") *(max_height) + ("#"*max_width).to_s
#   # Create runners that make paths in room
#   runners.times do
#     random_number = rand(0..100)
#     horizontal_wall_location = (rand(rand(2..10)..(max_width - rand(2..10))) + max_width)
#     verticle_wall_location = ((rand(rand(2..10)..(max_height - rand(2..10))) + max_height) * rand(1..max_width))
#     # Make horizontal runner 50% of the time
#     # Make verticle runner 50% of the time
#     if random_number.even?
#       max_height.times do
#         floor[horizontal_wall_location] = " "
#         horizontal_wall_location += (max_width + 1)
#       end
#     else random_number
#       max_width.times do
#         floor[verticle_wall_location] = " "
#         verticle_wall_location += 1
#       end
#     end
#   end
#   return floor
# end

puts create_map(max_width, max_height, 30, 1)
