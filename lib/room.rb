require 'io/console'

class Room

  def initialize
    @door_location = nil
    @player_location = nil
    @width = 27
    @height = 12
    @room =
"---------------------------
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
|                         |
---------------------------"
  end
  # Prints a room to the screen
  def draw_room
    puts @room
  end

  def add_bottom_door
    @door_location = (@room.length) - (@width/2)
    @room[@door_location] = "|"
    @room[@door_location + 1] = "|"
  end

  def spawn_player
    @player_location = @door_location - @width
    @room[@player_location] = "@"
  end

  def move_up
    if @room[@player_location - (@width + 1)] == " "
      @room[@player_location] = " "
      @player_location -= (@width + 1)
      @room[@player_location] = "@"
    end
  end

  def move_down
    if @room[@player_location + (@width + 1)] == " "
      @room[@player_location] = " "
      @player_location += (@width + 1)
      @room[@player_location] = "@"
    end
  end

  def move_right
    if @room[@player_location + 1] == " "
      @room[@player_location] = " "
      @player_location += 1
      @room[@player_location] = "@"
    end
  end

  def move_left
    if @room[@player_location - 1] == " "
      @room[@player_location] = " "
      @player_location -= 1
      @room[@player_location] = "@"
    end
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def movement_loop
    while true
      draw_room
      system("stty raw -echo")
      user_input = STDIN.getc
      system("stty -raw echo")
      case user_input
      when "d"
        move_right
      when "a"
        move_left
      when "w"
        move_up
      when "s"
        move_down
      when "p"
        break
      else
        puts "select valid command"
      end
      clear_screen
    end
  end
end

# puts 'Do you want to proceed? y/n'
#
# loop do
#   system("stty raw -echo")
#   c = STDIN.getc
#   system("stty -raw echo")
#
#   case c
#   when 'y'
#     puts 'Yes'
#     break
#   when 'n'
#     puts 'No'
#     break
#   else
#     puts 'Please type "y" or "n"'
#   end
# end
#
room = Room.new
room.clear_screen
room.add_bottom_door
room.spawn_player
room.movement_loop
