class Room < ActiveRecord::Base
  has_many :items
  has_many :players, through: :items
  attr_accessor :floor, :width, :height

  after_initialize do
    #we could refactor this to generate a random sized room for every instance
    @width = (`tput cols`.to_i) #rand(12...20)
    @height = (`tput lines`.to_i - 5)  #((width * 2) + 3)
    @floor = ("-"*@width) + ("|" + (" "*(@width - 2)) + "|\n") *(@height) + ("-"*@width).to_s    # could create a constructor method below that uses the instance height to generate a room with the appropriate number of '-', ' ', and '|'

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

    #generates a random number between 1 & 3
    num_items = rand(1...10)
    num_items.times do
      loop do
        #select a random number between ((after first row)..(before last row))
        spawn_coordinate = rand((@width + 10)..(@floor.length - (@width +10)))
          #if the floor[at that coordinate] is blank
          if @floor[spawn_coordinate] == " "
            #then replace that coordinate with an 'i' and break out of the loop.
            @floor[spawn_coordinate] = "i"
            break
          end
      end
    end
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

  def create_map
    wall = "#"
    space = " "
    line_end = "\n"
    horizontal_group = self.width/10
    verticle_group = self.height/10
    solid_line = wall*self.width

    final_map = ""
    final_map += solid_line + line_end
    self.height.times do
      verticle_group.times do
        final_map += (wall + (space*horizontal_group) + wall)*horizontal_group + line_end
      end
      final_map += solid_line + line_end
    end
    return final_map
  end
  #show this instance of the floorplan
  def draw_room
    puts self.floor
  end


end
