require_relative '../config/environment.rb'
require_relative 'game.rb'


Game.new.movement_loop(Room.create)
