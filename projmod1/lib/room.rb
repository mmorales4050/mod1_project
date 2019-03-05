class Room < ActiveRecord::Base
  has_many :items
  has_many :players, through: :items

  attr_accessor :floor, :width, :height

  after_initialize do
    num_items = rand(1...3)
    @width = 27
    @height = 12
    @floor =
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

    num_items.times do
      loop do
        spawn_location = rand((@width + 10)..(@floor.length - (@width +10)))
          if @floor[spawn_location] == " "
            @floor[spawn_location] = "i"
            break
          end
      end

    end

  end

  def draw_room
    puts self.floor
  end


end
