class Room < ActiveRecord::Base
  has_many :items
  has_many :players, through: :items
  attr_accessor :floor, :width, :height

  after_initialize do
    #we could refactor this to generate a random sized room for every instance
    @width = `tput cols`.to_i #rand(12...20)
    @height = (`tput lines`.to_i - 5)  #((width * 2) + 3)
    @floor = ("#"*@width) + ("#" + ("#"*(@width - 2)) + "#\n") *(@height) + ("#"*@width).to_s#("-"*@width) + ("|" + (" "*(@width - 2)) + "|\n") *(@height) + ("-"*@width).to_s    # could create a constructor method below that uses the instance height to generate a room with the appropriate number of '-', ' ', and '|'
    #@floor = ("-"*@width) + ("|" + (" "*(@width - 2)) + "|\n") *(@height) + ("-"*@width).to_s
# "---------------------------
# |                         |
# |                         |
# |                         |
# |                         |
# |                         |
# |                         |
# |                         |
# |                         |
# |                         |
# |                         |
# ---------------------------"

    #Create location for items to spawn
    # num_items = rand(1...10)
    # num_items.times do
    #   loop do
    #     #select a random number between ((after first row)..(before last row))
    #     spawn_coordinate = rand((@width + 10)..(@floor.length - (@width +10)))
    #       #if the floor[at that coordinate] is blank
    #       if @floor[spawn_coordinate] == " "
    #         #then replace that coordinate with an 'i' and break out of the loop.
    #         @floor[spawn_coordinate] = "i"
    #         break
    #       end
    #   end
    # end
  end

  # def create_map(width, height)
  #   floor = ("-"*width) + ("|" + (" "*(width - 2)) + "|\n") *(height) + ("-"*width).to_s    # could create a constructor method below that uses the instance height to generate a room with the appropriate number of '-', ' ', and '|'
  #   number_of_walls = rand(50..70)
  #   number_of_walls.times do
  #     wall_location = (rand(2..(width - 2)) + width)
  #     height.times do
  #       if rand(0..100) > 60
  #         floor[wall_location] = " "
  #       else
  #         floor[wall_location] = "x"
  #       end
  #       wall_location += (width + 1)
  #     end
  #   end
  #   return floor
  # end

  def create_map(runners, player)
    #player = Player.new
    player.location = ((self.floor.length/2) + 15)
    self.floor[player.location] = "@"
    runners.times do
      Game.clear_screen
      self.draw_room
      sleep(0)
      directions = [:down, :up, :left, :right]
      random_less_than_width = rand(2..(self.width - 2))
      random_less_than_height = rand(2..(self.height - 2))
      rand(0..20).times do
        direction = directions.shuffle.first
          if direction == :down || direction == :up
            (random_less_than_width/4).times do
              player.move_runner(direction, self, "#")
            end
          else
            (random_less_than_height/4).times do
              player.move_runner(direction, self, "#")
            end
          end
        end
      end
  end

  #show this instance of the floorplan
  def draw_room
    puts self.floor
  end


end
