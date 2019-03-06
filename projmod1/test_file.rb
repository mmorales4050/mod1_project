require_relative 'config/environment.rb'
require_relative 'bin/game.rb'

Game.clear_screen

height = `tput cols`

width = `tput lines`

floor = "-"*height.to_i + ("|" + (" "*(height.to_i - 2)) + "|\n") *(width.to_i - 3) + "-"*height.to_i

print floor
