class Room < ActiveRecord::Base
  has_many :items
  has_many :players, through: :items
  attr_accessor :floor, :width, :height

  after_initialize do
    #we could refactor this to generate a random sized room for every instance
    @height = 12 #rand(12...20)
    @width = 27  #((height * 2) + 3)
    @floor =     # could create a constructor method below that uses the instance height to generate a room with the appropriate number of '-', ' ', and '|'
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
---------------------------"

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


  #show this instance of the floorplan
  def draw_room
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:doom)
    pastel = Pastel.new

    puts "\n"
    puts pastel.bright_white.bold(font.write("THE ROOM"))
    puts "\n"
    puts self.floor
  end


end
