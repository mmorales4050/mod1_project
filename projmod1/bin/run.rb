require_relative '../config/environment.rb'

Room.create(name: "first_room")
puts Room.all
