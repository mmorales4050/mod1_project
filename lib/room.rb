require 'io/console'

class Room < ActiveRecord::Base
  has_many :item


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
---------------------------\n\n"
  end
  # Prints a room to the screen
  def draw_room
    puts @room
    # puts "Inventory:"
    # puts self.inventory
  end

  def room(inventory)

    @room
  end

  def inventory

    @inventory = Item.all.select { |item| item.in_inventory? == true }.map{|item| item.name}
  end

  #places a '0' for the location of an item
  def place_item
    @item_location = ((@room.length/2) + 10)
    @room[@item_location] = "0"
  end

  def clear_inventory
    Item.find_by(name: "sword").update(in_inventory?: false)
    # inventory.each { |item| item.update(in_inventory?: false)}
  end

  def pickup_item
    # sword = Item.find_by(name: 'sword')
    # sword.update(in_inventory?: true)
    item = Item.generate_item.update(in_inventory?: true)
    Player.create(item: item)
  end

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

  def inventory_display
    puts "Inventory:"
    puts self.inventory
    user_input = nil
    while user_input.nil?
      system("stty raw -echo")
      user_input = STDIN.getc
      system("stty -raw echo")
    end
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
      when "i"
        inventory_display
      when "p"
        Item.destroy_all
        break
      else
        puts "select valid command"
      end
        # puts self.inventory
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
# room.place_item
# room.add_bottom_door
# room.spawn_player
# room.movement_loop
