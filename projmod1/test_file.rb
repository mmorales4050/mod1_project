require_relative 'config/environment.rb'
require_relative 'bin/game.rb'

Game.clear_screen

width = `tput cols`.to_i #rand(12...20)
height = (`tput lines`.to_i - 5)  #((width * 2) + 3)
def create_map(width, height)
  floor = ("-"*width) + ("|" + (" "*(width - 2)) + "|\n") *(height) + ("-"*width).to_s    # could create a constructor method below that uses the instance height to generate a room with the appropriate number of '-', ' ', and '|'
  number_of_walls = rand(50..70)
  number_of_walls.times do
    wall_location = (rand(2..(width - 2)) + width)
    height.times do
      if rand(0..100) > 60
        floor[wall_location] = " "
      else
        floor[wall_location] = "x"
      end
      wall_location += (width + 1)
    end
  end
  return floor
end

print create_map(width, height)
