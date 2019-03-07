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
    Game.clear_screen
    player = Player.new
    room = Room.create
    # create_map method adds walls to the map
    #room.floor = room.create_map
    spawn_player(room, player)
    room.draw_room
    player_inv = 0

    #spawn_item(room)
    while true
      # Check if items break
      item_just_broke = false
      if player_inv > 0 && rand(100) == 2
        item_just_broke = true
      end
      player_inv = Item.all.length
      if player_inv > 0
        item_damage = Item.all.last.damage
      end
      user_input = Game.get_input
      inv_open = false
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
            inv_open = true
          when "p"
            Item.destroy_all
            break
          end

      room.draw_room
      if inv_open == true
        player.inventory_display
      end
      # left off here
      if player_inv > 0
        if Item.all.last.damage > item_damage
          puts "Your items have been enchanted!(+1 damage)"
        end
      end

      if Item.all.length > player_inv
        puts "You picked up a #{Item.last.name}"
      end

      if item_just_broke == true
        puts "Your #{Item.first.name} just broke!"
        Item.first.delete
      end
    end

  end

end
