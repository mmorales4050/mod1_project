require_relative "../config/environment.rb"
#
# inventory = " "
# item_location = nil
# door_location = nil

class Game

  def spawn_player(room, player)
    player.location = ((room.floor.length/2) + 15)
    room.floor[player.location] = "@"
  end

  def self.clear_screen
    puts "\e[H\e[2J"
  end

  #allows the press of any key to be registered without needing to hit 'enter'
  def self.get_input
    system("stty raw -echo")
    user_input = STDIN.getc
    system("stty -raw echo")
    user_input
  end

  def game_loop
    player = Player.new
    room = Room.create
    spawn_player(room, player)
    room.draw_room

    #spawn_item(room)
    while true
      player_inv = Item.all.length
      user_input = Game.get_input
      inv_open = 0
      Game.clear_screen

          case user_input
          when "d"
            player.move(:right, room)
          when "a"
            player.move(:left, room)
          when "w"
            player.move(:up, room)
          when "s"
            player.move(:down, room)
          when "i"
            inv_open = 1
          when "p"
            Item.destroy_all
            break
          end
          
      room.draw_room
      if inv_open == 1
        player.inventory_display
      end

      if Item.all.length > player_inv
        puts "You picked up a #{Item.last.name}"
      end

    end

  end

end
