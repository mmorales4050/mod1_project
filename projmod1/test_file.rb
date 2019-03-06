require_relative 'config/environment.rb'
require_relative 'bin/game.rb'

Game.clear_screen
terminal_size = `tput cols`
terminal_size_1 = `tput lines`

print "-"*terminal_size.to_i

print  ("|" + (" "*(terminal_size.to_i - 2)) + "|\n") *(terminal_size_1.to_i - 3)

print "-"*terminal_size.to_i
