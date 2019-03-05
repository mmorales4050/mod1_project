class Player < ActiveRecord::Base
  has_many :items
  has_many :rooms, through: :items

  attr_accessor :location

  @@location = nil

  def self.location
    @@location
  end

  def self.location=(variable)
    @@location = variable
  end

  def self.inventory_display
    puts "Inventory:"
    # puts self.inventory
    user_input = nil
    while user_input.nil?
      user_input = Game.get_input
    end
  end


  def self.move(operator, room)
    room.floor[self.location] = " "

    case operator
    when :up
      if room.floor[self.location - (room.width + 1)] == " "
        self.location -= (room.width + 1)
      elsif room.floor[self.location - (room.width + 1)] == "0"
        pickup_item
        self.location -= (room.width + 1)
      end

    when :down
      if room.floor[self.location + (room.width + 1)] == " "
        self.location += (room.width + 1)
      end

    when :right
      if room.floor[self.location + 1] == " "
        self.location += 1
      end

    when :left
      if room.floor[self.location - 1] == " "
        self.location -= 1
      end
    end

    room.floor[self.location] = "@"
  end

end
