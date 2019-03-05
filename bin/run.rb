require_relative '../config/environment.rb'

room = Room.new
room.clear_inventory
room.clear_screen
room.place_item
room.spawn_player
room.movement_loop
