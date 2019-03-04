class Room

  def initialize
    @room =
"--------------------------
|                        |
|                        |
|                        |
|                        |
|                        |
|                        |
|                        |
|                        |
|                        |
--------------------------"
  end
  # Prints a room to the screen
  def draw_room
    puts @room
  end

  def move_up(location)
    location - 10
    @room[]

  def add_player(number)
    @room[number] = "@"
    draw_room
    sleep(1)
    puts "\e[H\e[2J"
    @room[number] = " "
  end
end

new_room = Room.new

new_room.add_player(40)
new_room.add_player(41)
new_room.add_player(42)
new_room.add_player(43)
new_room.add_player(44)
new_room.add_player(45)
new_room.add_player(46)
new_room.add_player(47)
