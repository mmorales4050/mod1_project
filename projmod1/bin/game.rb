require_relative "../config/environment.rb"
#
# inventory = " "
# item_location = nil
# door_location = nil

class Game

  def spawn_player(room)
    Player.location = ((room.floor.length/2) + 15)
    room.floor[Player.location] = "@"
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def self.get_input
    system("stty raw -echo")
    user_input = STDIN.getc
    system("stty -raw echo")
    user_input
  end

  def movement_loop(room)
    spawn_player(room)
    while true
      room.draw_room
      user_input = Game.get_input
      case user_input
      when "d"
        Player.move(:right, room)
      when "a"
        Player.move(:left, room)
      when "w"
        Player.move(:up, room)
      when "s"
        Player.move(:down, room)
      when "i"
        Player.inventory_display
      when "p"
        # Item.destroy_all
        break
      else
        puts "select valid command"
      end
        # puts self.inventory
      self.clear_screen
    end
  end
end
