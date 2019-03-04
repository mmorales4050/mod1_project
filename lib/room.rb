require 'io/console'

class Room < ActiveRecord::Base

  after_initialize do |room|
    # Add class for item
    @inventory = " "
    @item_location = nil
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
---------------------------\n\n
Inventory: #{self.inventory}"
  end
  # Prints a room to the screen
  def draw_room
    puts @room
  end

  def inventory
    @inventory = Item.all.select { |item| item.in_inventory? == true }
  end

  def add_item
    @item_location = ((@room.length/2) + 10)
    @room[@item_location] = "0"
  end

  def clear_inventory
    inventory.each { |item| item.update(in_inventory?: false)}
  end

  def pickup_item
    # Add item to inventory
    # Add item to database
    #sword.in_inventory? = true

    sword = Item.find_by(name: 'sword')
    sword.update(in_inventory?: true)
    clear_screen
    draw_room
  end

  # def add_bottom_door
  #   @door_location = (@room.length) - (@width/2)
  #   @room[@door_location] = "|"
  #   @room[@door_location + 1] = "|"
  # end

  def spawn_player
    @player_location = ((@room.length/2) + 15)
    @room[@player_location] = "@"
  end

  def move(operator)
    @room[@player_location] = " "

    case operator
    when :up
      if @room[@player_location - (@width + 1)] == " "
        @player_location -= (@width + 1)
      elsif @room[@player_location - (@width + 1)] == "0"
        pickup_item
        @player_location -= (@width + 1)
      end

    when :down
      if @room[@player_location + (@width + 1)] == " "
        @player_location += (@width + 1)
      end

    when :right
      if @room[@player_location + 1] == " "
        @player_location += 1
      end

    when :left
      if @room[@player_location - 1] == " "
        @player_location -= 1
      end
    end

    @room[@player_location] = "@"
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
        move(:right)
      when "a"
        move(:left)
      when "w"
        move(:up)
      when "s"
        move(:down)
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
# room = Room.new
# room.clear_screen
# room.add_item
# room.add_bottom_door
# room.spawn_player
# room.movement_loop
