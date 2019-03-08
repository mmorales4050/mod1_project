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

  def title_screen
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:doom)
    pastel = Pastel.new

    puts "\n"
    puts pastel.bright_white.bold(font.write("   THE       WEAPON       COLLECTOR"))
    puts "\n"
    Game.get_input
  end

  def getch_loop(counter)
    while counter > 0
      %x[stty -echo raw]
      $stdin = StringIO.new("John Doe\n")
      %x[stty echo -raw]
      counter -= 1
    end
  end

  def game_loop
    Game.clear_screen
    self.title_screen

    player = Player.new
    room = Room.create
    turn = 100
    spawn_player(room, player)
    room.draw_room
    player_inv = 0

    #spawn_item(room)
    while true
      # Check if items break
      item_just_broke = false
      if player_inv > 0 && rand(150) == 4
        item_just_broke = true
      end
      player_inv = Item.all.length
      if player_inv > 0
        item_damage = Item.all.last.damage
      end
      user_input = Game.get_input
      inv_open = false
      Game.clear_screen
      puts "you have #{turn}'s left"

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
      turn -= 1


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

      if turn == 0
        Game.clear_screen
        puts "You collected #{Item.all.count} weapons! Congratulations on your hard work and good luck finding a better game. "
        break
      end
    end

  end

end
