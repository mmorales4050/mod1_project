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

  def title_screen(room)
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:doom)
    pastel = Pastel.new

    puts "\n"
    if room.width > 140
      puts pastel.bright_white.bold(font.write("THE       WEAPON       COLLECTOR".center(room.width - 141 + 32 )))
    else
      puts "THE WEAPON COLLECTOR".center(room.width)
    end
    puts "\n"

    puts "You wake up in a strange room with no food and no water but you know " +
    "you can last about 100 hours before you die of dehydration. \n You hear a " +
    "voice over an intercom stating that you're doomed to die here until and " +
    "unless you can find at least 10 weapons. \n Due to the stressful " +
    "conditions you decide the best course of action is to find as many" +
    " weapons as possible within the remainder of your life. \n You notice "+
    "plenty of treasure chests littered around the room and decide to test your luck. \n \n \n  \n"

    puts "Press any key to continue".center(room.width)

    Game.get_input
  end

  def game_loop
    player = Player.new
    room = Room.create
    Game.clear_screen
    self.title_screen(room)
    Game.clear_screen

    spawn_player(room, player)
    last_message = ""
    turn = 99 # number of moves before game ends
    puts "you have #{turn +1} hours left"
    room.draw_room
    player_inv = 0

    #spawn_item(room)
    while true
      # Check if items break
          item_just_broke = player_inv > 0 && rand(150) < 4
          player_inv = Item.all.length
          if player_inv > 0
            item_damage = Item.all.last.damage
          end
      user_input = Game.get_input
      Game.clear_screen
      puts "you have #{turn} hours left"

          case user_input
          when "d"
            player.move(:right, room)
          when "a"
            player.move(:left, room)
          when "w"
            player.move(:up, room)
          when "s"
            player.move(:down, room)
          when "p"
            Item.destroy_all
            break
          end

      if player_inv > 0
        if Item.all.last.damage > item_damage
          last_message = "Your items have been enchanted!(+1 damage)"
        end
      end

      if Item.all.length > player_inv
        last_message = "You picked up a #{Item.last.name}"
      end

      if item_just_broke
        last_message = "Your #{Item.first.name} just broke!"
        Item.first.delete
      end

      if turn == 0
        Game.clear_screen
        puts "You collected #{Item.all.count} weapons! Congratulations on your hard work but you did not collect enough weapons.......you died. "
        Item.destroy_all
        break
      end

      if Item.all.count >= 10
        Game.clear_screen
        puts "CONGRATULATIONS! YOU WERE RELEASED FROM YOUR ETERNAL PRISON AFTER #{100 - turn} HOURS"
        Item.destroy_all
        break
      end

      room.draw_room
      puts last_message
      turn -= 1
      player.inventory_display

    end
    # ^^ end of the game loop

  end

end
