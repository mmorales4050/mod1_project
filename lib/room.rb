class Room < ActiveRecord::Base
  has_many :items
  has_many :players, through: :items
  attr_accessor :floor, :width, :height

  ##

  after_initialize do
    @width = `tput cols`.to_i # set width = to terminal window width
    @height = (`tput lines`.to_i - 7)  # set length = to terminal window length
    # floor = string including a top wall +  left side wall + inner space + right side wall + bottom wall
    @floor = ("-"*@width) + ("|" + (" "*(@width - 2)) + "|\n") *(@height) + ("-"*@width).to_s

    # generate a random number commenserate with the size of the terminal
    num_items = (rand(5..@width) + rand(5..@height))
    num_items.times do
      loop do
        # generate a random coordinate within the inner space of the room
        spawn_coordinate = rand((@width + 10)..(@floor.length - (@width +10)))
          # if the floor[at that coordinate] == an empty space...
          if @floor[spawn_coordinate] == " "
            # ... go ahead and place a treasure chest
            @floor[spawn_coordinate] = "T"
            break
          end
      end
    end
  end

  # simply prints out the floorplan.
  def draw_room
    puts self.floor
  end

end
